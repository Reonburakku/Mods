// Configuración de la página.
//
// ROM_BASE_URL: carpeta (terminada en /) que contiene la ROM (y manifest.json).
//   Desarrollo (localhost): "./rom-dev/"  (lo genera: python tools/release.py <versión>)
//   Publicada: el blob de Azure
// Se puede sobrescribir sin tocar el código con ?rom=<url> en la dirección de la página.
const params = new URLSearchParams(location.search);
const IS_LOCAL = ["localhost", "127.0.0.1", "[::1]"].includes(location.hostname);

export const ROM_BASE_URL = params.get("rom") ?? (IS_LOCAL ? "./rom-dev/" : "https://nesroms.blob.core.windows.net/psx/");

// Manifiesto de la versión publicada (el blob no tiene manifest.json): si es null, se
// descarga ROM_BASE_URL + "manifest.json". Al publicar otra versión, actualizar aquí.
export const ROM_MANIFEST = params.has("rom") || IS_LOCAL ? null : {
  version: "1.0.0",
  file: "contra4p-0.1.11.nes",
  sha1: "2b24903bf74cc5dee9ca885e168f24a93a182c6d",
  size: 262160,
  players: 4,
  overclock: 60,
};

// Servidores TURN para el juego en red (opcional). Hacen falta solo cuando los
// navegadores no consiguen conectarse directamente (algunas redes móviles, de empresa,
// VPN…). Formato WebRTC: [{ urls: "turn:host:3478", username: "…", credential: "…" }]
// También se puede pasar en la dirección: ?turn=turn:host:3478|usuario|clave
export const TURN_SERVERS = (() => {
  const t = params.get("turn");
  if (!t) return [];
  const [urls, username, credential] = t.split("|");
  return [{ urls, username, credential }];
})();

// Servidores TURN de Metered (metered.ca, plan gratuito): credencial de la app
// "reonburakku", copiada del panel (TURN Server -> Credentials). Es una credencial
// solo de TURN: queda visible en la página, como en cualquier web con TURN.
const METERED_USER = "18a6c0930c436afadd9ad7ae";
const METERED_PASS = "TEQm6HqxJEUiwLCf";   // contraseña de la credencial (vacía = sin TURN)
const METERED_ICE = METERED_PASS ? [
  { urls: "stun:stun.relay.metered.ca:80" },
  ...["turn:global.relay.metered.ca:80", "turn:global.relay.metered.ca:80?transport=tcp",
    "turn:global.relay.metered.ca:443", "turns:global.relay.metered.ca:443?transport=tcp"]
    .map((urls) => ({ urls, username: METERED_USER, credential: METERED_PASS })),
] : [];

// Alternativa: dirección de una API que devuelva la lista de servidores con
// credenciales temporales (p. ej. https://<app>.metered.live/api/v1/turn/credentials?apiKey=<clave>
// con la clave de una credencial, nunca la clave secreta de la cuenta). Vacío = no se usa.
export const TURN_API_URL = "";

// Diagnóstico: ?relay=1 obliga a que todo el tráfico pase por el servidor TURN
// (como si la conexión directa no fuera posible).
export const FORCE_RELAY = params.get("relay") === "1";

/** Servidores TURN para la sesión: ?turn=, los de METERED_ICE o los de TURN_API_URL. Nunca falla: sin TURN, []. */
export async function loadTurnServers() {
  if (TURN_SERVERS.length) return TURN_SERVERS;
  if (!TURN_API_URL) return METERED_ICE;
  try {
    const ctl = new AbortController();
    const timer = setTimeout(() => ctl.abort(), 5000);
    const res = await fetch(TURN_API_URL, { signal: ctl.signal, cache: "no-store" });
    clearTimeout(timer);
    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    const list = await res.json();
    if (!Array.isArray(list)) throw new Error("respuesta inesperada");
    return list.filter((s) => s && s.urls);
  } catch (e) {
    console.warn("No se pudieron obtener los servidores TURN; se intenta la conexión directa:", e);
    return [];
  }
}

// En pruebas locales (dos pestañas en el mismo equipo) el navegador oculta la IP
// local con un nombre "xxxx.local" (mDNS) que Windows a menudo no resuelve.
// Con la página en localhost esos nombres se sustituyen por 127.0.0.1.
// Overclock del emulador (líneas extra de VBlank). Por defecto el que recomienda el
// manifiesto de la ROM; ?overclock=N lo cambia (en red manda el del anfitrión).
export const OVERCLOCK_OVERRIDE = params.has("overclock") ? Number(params.get("overclock")) | 0 : null;

export const LOCAL_LOOPBACK = ["localhost", "127.0.0.1", "[::1]"].includes(location.hostname);
