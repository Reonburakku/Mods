# Librerías de terceros (sin modificar)

| Carpeta | Paquete | Licencia |
|---|---|---|
| `trystero-nostr/` | `@trystero-p2p/nostr@0.26.0` (dist) | MIT |
| `trystero-core/` | `@trystero-p2p/core@0.26.0` (dist) | MIT |
| `noble-secp256k1/` | `@noble/secp256k1@3.2.0` | MIT |

Cambios: se han quitado los comentarios `sourceMappingURL`, y en `trystero-nostr/index.mjs` los
imports `@noble/secp256k1` y `@trystero-p2p/core` apuntan a las carpetas vecinas (rutas relativas),
para cargarlos en el navegador sin empaquetador.
Para actualizar: `npm install --save-exact trystero@X` y volver a copiar los `dist/*.mjs`.
