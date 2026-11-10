// Configuración de la página.
//
// ROM_BASE_URL: carpeta (terminada en /) que contiene manifest.json y la ROM.
//   Desarrollo: "./rom-dev/"  (lo genera: python tools/release.py <versión>)
//   Producción: "https://<cuenta>.blob.core.windows.net/roms/"
// Se puede sobrescribir sin tocar el código con ?rom=<url> en la dirección de la página.
const params = new URLSearchParams(location.search);

export const ROM_BASE_URL = params.get("rom") ?? "./rom-dev/";

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

// En pruebas locales (dos pestañas en el mismo equipo) el navegador oculta la IP
// local con un nombre "xxxx.local" (mDNS) que Windows a menudo no resuelve.
// Con la página en localhost esos nombres se sustituyen por 127.0.0.1.
// Overclock del emulador (líneas extra de VBlank). Por defecto el que recomienda el
// manifiesto de la ROM; ?overclock=N lo cambia (en red manda el del anfitrión).
export const OVERCLOCK_OVERRIDE = params.has("overclock") ? Number(params.get("overclock")) | 0 : null;

export const LOCAL_LOOPBACK = ["localhost", "127.0.0.1", "[::1]"].includes(location.hostname);
