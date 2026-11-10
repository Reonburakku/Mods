// Descarga la ROM indicada por manifest.json, comprueba su SHA-1 y la guarda en
// IndexedDB para no volver a descargarla mientras no cambie la versión.
import { sha1HexJs } from "./sha1.js";

const DB_NAME = "contra4p";
const STORE = "roms";

/**
 * @param {string} baseUrl carpeta con manifest.json (terminada en /)
 * @param {(msg: string, fraction?: number) => void} onProgress
 * @returns {Promise<{bytes: Uint8Array, manifest: {version: string, file: string, sha1: string, size: number}, fromCache: boolean}>}
 */
export async function loadRom(baseUrl, onProgress = () => {}) {
  onProgress("Comprobando versión…");
  let manifest;
  try {
    const res = await fetch(new URL("manifest.json", new URL(baseUrl, location.href)), { cache: "no-cache" });
    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    manifest = await res.json();
  } catch (e) {
    // Sin conexión: usar la última ROM guardada si la hay
    const cached = await dbGetLatest().catch(() => null);
    if (cached) return { bytes: cached.bytes, manifest: cached.manifest, fromCache: true };
    throw new Error(`No se pudo descargar manifest.json (${e.message}). ` +
      `Si la ROM está en Azure Blob, revisa la configuración CORS de la cuenta.`);
  }
  validateManifest(manifest);

  const cached = await dbGet(manifest.sha1).catch(() => null);
  if (cached) {
    onProgress("ROM en caché", 1);
    return { bytes: cached.bytes, manifest, fromCache: true };
  }

  const url = new URL(manifest.file, new URL(baseUrl, location.href));
  const bytes = await download(url, manifest.size, (f) => onProgress("Descargando ROM…", f));
  const sha1 = await sha1Hex(bytes);
  if (sha1 !== manifest.sha1) {
    throw new Error(`La ROM descargada no coincide con el manifiesto (SHA-1 ${sha1}, se esperaba ${manifest.sha1}).`);
  }
  await dbReplace({ sha1, manifest, bytes, savedAt: Date.now() }).catch((e) =>
    console.warn("No se pudo guardar la ROM en caché:", e));
  return { bytes, manifest, fromCache: false };
}

function validateManifest(m) {
  const ok = m && typeof m.version === "string" && typeof m.file === "string" &&
    /^[0-9a-f]{40}$/.test(m.sha1) && Number.isInteger(m.size) && !/[/\\]/.test(m.file);
  if (!ok) throw new Error("manifest.json no tiene el formato esperado.");
}

async function download(url, expectedSize, onFraction) {
  const res = await fetch(url);
  if (!res.ok) throw new Error(`No se pudo descargar la ROM (HTTP ${res.status}).`);
  const total = Number(res.headers.get("Content-Length")) || expectedSize;
  if (!res.body) return new Uint8Array(await res.arrayBuffer());
  const reader = res.body.getReader();
  const chunks = [];
  let received = 0;
  for (;;) {
    const { done, value } = await reader.read();
    if (done) break;
    chunks.push(value);
    received += value.length;
    onFraction(Math.min(1, received / total));
  }
  const bytes = new Uint8Array(received);
  let off = 0;
  for (const c of chunks) { bytes.set(c, off); off += c.length; }
  return bytes;
}

export async function sha1Hex(bytes) {
  if (!globalThis.crypto?.subtle) return sha1HexJs(bytes);   // http:// fuera de localhost
  const digest = await crypto.subtle.digest("SHA-1", bytes);
  return [...new Uint8Array(digest)].map((b) => b.toString(16).padStart(2, "0")).join("");
}

// ---------------------------------------------------------------- IndexedDB
function openDb() {
  return new Promise((resolve, reject) => {
    const req = indexedDB.open(DB_NAME, 1);
    req.onupgradeneeded = () => req.result.createObjectStore(STORE, { keyPath: "sha1" });
    req.onsuccess = () => resolve(req.result);
    req.onerror = () => reject(req.error);
  });
}

async function tx(mode, fn) {
  const db = await openDb();
  try {
    return await new Promise((resolve, reject) => {
      const t = db.transaction(STORE, mode);
      const result = fn(t.objectStore(STORE));
      t.oncomplete = () => resolve(result.value);
      t.onerror = () => reject(t.error);
    });
  } finally {
    db.close();
  }
}

function dbGet(sha1) {
  return tx("readonly", (s) => {
    const out = {};
    s.get(sha1).onsuccess = (e) => { out.value = e.target.result ?? null; };
    return out;
  });
}

function dbGetLatest() {
  return tx("readonly", (s) => {
    const out = { value: null };
    s.getAll().onsuccess = (e) => {
      const all = e.target.result;
      out.value = all.sort((a, b) => b.savedAt - a.savedAt)[0] ?? null;
    };
    return out;
  });
}

/** Guarda la ROM nueva y borra las versiones anteriores. */
function dbReplace(entry) {
  return tx("readwrite", (s) => {
    s.clear();
    s.put(entry);
    return {};
  });
}
