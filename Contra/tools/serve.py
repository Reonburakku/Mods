"""
Servidor de desarrollo de la web (web/) sin caché, para que el navegador siempre
cargue la última versión de los archivos.

Uso:  python tools/serve.py [puerto]        (por defecto 8080, solo en este equipo)
      python tools/serve.py 8080 --lan      (accesible desde otros equipos de la red)
"""
import functools
import http.server
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


class NoCacheHandler(http.server.SimpleHTTPRequestHandler):
    extensions_map = {**http.server.SimpleHTTPRequestHandler.extensions_map,
                      ".js": "text/javascript", ".mjs": "text/javascript", ".nes": "application/octet-stream"}

    def end_headers(self):
        self.send_header("Cache-Control", "no-store")
        super().end_headers()


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    port = int(args[0]) if args else 8080
    host = "0.0.0.0" if "--lan" in sys.argv else "127.0.0.1"
    handler = functools.partial(NoCacheHandler, directory=os.path.join(ROOT, "web"))
    with http.server.ThreadingHTTPServer((host, port), handler) as httpd:
        print(f"Sirviendo web/ en http://localhost:{port}  (Ctrl+C para parar)")
        httpd.serve_forever()


if __name__ == "__main__":
    main()
