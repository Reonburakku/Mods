"""
Prepara (y opcionalmente sube a Azure Blob) una versión de la ROM para la web.

Uso:
  python tools/release.py 0.1.0                       -> web/rom-dev/  (pruebas locales)
  python tools/release.py 0.1.0 --upload \\
      --account MI_CUENTA --container roms            -> sube a Azure (requiere "az login")

Genera:
  contra4p-<versión>.nes   la ROM (build/contra.nes); nombre con versión = inmutable
  manifest.json            {"version", "file", "sha1", "size"}

Al subir, primero va la ROM y después el manifiesto, para que nadie reciba un
manifiesto que apunte a un archivo que aún no existe.
"""
import argparse
import hashlib
import json
import os
import re
import shutil
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("version", help="versión, p. ej. 0.1.0")
    ap.add_argument("--rom", default=os.path.join(ROOT, "build", "contra.nes"))
    ap.add_argument("--out", default=os.path.join(ROOT, "web", "rom-dev"))
    ap.add_argument("--upload", action="store_true", help="subir a Azure Blob Storage con la CLI 'az'")
    ap.add_argument("--account", help="cuenta de almacenamiento de Azure")
    ap.add_argument("--container", default="roms")
    args = ap.parse_args()

    if not re.fullmatch(r"\d+\.\d+\.\d+", args.version):
        sys.exit("La versión debe tener la forma 1.2.3")
    rom = open(args.rom, "rb").read()
    if rom[:4] != b"NES\x1a":
        sys.exit(f"{args.rom} no es una ROM iNES")

    name = f"contra4p-{args.version}.nes"
    manifest = {
        "version": args.version,
        "file": name,
        "sha1": hashlib.sha1(rom).hexdigest(),
        "size": len(rom),
    }
    os.makedirs(args.out, exist_ok=True)
    rom_out = os.path.join(args.out, name)
    man_out = os.path.join(args.out, "manifest.json")
    shutil.copyfile(args.rom, rom_out)
    with open(man_out, "w", encoding="utf-8", newline="\n") as f:
        json.dump(manifest, f, indent=2)
        f.write("\n")
    print(f"Preparado en {args.out}: {name} (sha1 {manifest['sha1']})")

    if args.upload:
        if not args.account:
            sys.exit("--upload necesita --account")
        az = shutil.which("az") or shutil.which("az.cmd")
        if not az:
            sys.exit("No se encuentra la CLI de Azure ('az'). Instálala y ejecuta 'az login'.")
        common = ["--account-name", args.account, "--container-name", args.container,
                  "--auth-mode", "login", "--overwrite", "true", "--only-show-errors"]
        uploads = [
            (rom_out, name, "application/octet-stream", "public, max-age=31536000, immutable"),
            (man_out, "manifest.json", "application/json", "no-cache"),
        ]
        for path, blob, ctype, cache in uploads:
            print(f"Subiendo {blob} ...")
            subprocess.run([az, "storage", "blob", "upload", "--file", path, "--name", blob,
                            "--content-type", ctype, "--content-cache-control", cache, *common],
                           check=True)
        print(f"Publicado: https://{args.account}.blob.core.windows.net/{args.container}/manifest.json")


if __name__ == "__main__":
    main()
