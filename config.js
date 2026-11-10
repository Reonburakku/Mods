// Configuración de la página.
//
// ROM_BASE_URL: carpeta (terminada en /) que contiene manifest.json y la ROM.
//   Desarrollo: "./rom-dev/"  (lo genera: python tools/release.py <versión>)
//   Producción: "https://<cuenta>.blob.core.windows.net/roms/"
// Se puede sobrescribir sin tocar el código con ?rom=<url> en la dirección de la página.
const params = new URLSearchParams(location.search);

export const ROM_BASE_URL = params.get("rom") ?? "./rom-dev/";
