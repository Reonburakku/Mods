"""Publica un juego en GitHub Pages (rama gh-pages) sin tocar los demás.

La rama gh-pages tiene una carpeta por juego más la portada común:

    gh-pages/
      index.html, .nojekyll   <- copiados de pages/ (portada con la lista de juegos)
      Contra4P/               <- Contra/web
      OtroJuego/              <- ...

Uso (desde cualquier carpeta del repositorio):

    python tools/publish_pages.py Contra/web Contra4P [--push]

Solo se reemplazan la carpeta indicada y los archivos de pages/; el resto de la rama
se conserva. Se publica lo que está confirmado en HEAD, no el árbol de trabajo.
"""
import argparse
import subprocess
import sys

BRANCH = "gh-pages"


def git(*args, input=None):
    # Bytes, no texto: en Windows el modo texto convierte \n en \r\n al escribir en stdin
    r = subprocess.run(["git", *args], input=input.encode("utf-8") if input else None, capture_output=True)
    if r.returncode != 0:
        sys.exit(f"git {' '.join(args)} falló:\n{r.stderr.decode('utf-8', 'replace')}")
    return r.stdout.decode("utf-8").strip()


def ls_tree(treeish):
    """{nombre: (modo, tipo, hash)} de las entradas de primer nivel."""
    out = {}
    for line in git("ls-tree", treeish).splitlines():
        meta, name = line.split("\t", 1)
        mode, typ, sha = meta.split()
        out[name] = (mode, typ, sha)
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("source", help="carpeta del repositorio con la web (p. ej. Contra/web)")
    ap.add_argument("target", help="carpeta destino en gh-pages (p. ej. Contra4P)")
    ap.add_argument("--push", action="store_true", help="subir gh-pages a origin")
    args = ap.parse_args()

    root = git("rev-parse", "--show-toplevel")
    git("-C", root, "rev-parse", "--verify", "HEAD")
    src = args.source.strip("/").replace("\\", "/")
    target = args.target.strip("/")
    if "/" in target or not target:
        sys.exit("El destino debe ser una carpeta de primer nivel.")

    dirty = git("-C", root, "status", "--porcelain", "--", src, "pages")
    if dirty:
        print("Aviso: hay cambios sin confirmar; se publica la versión de HEAD:\n" + dirty)

    # Partir de la gh-pages remota si existe, para no pisar lo publicado desde otro equipo
    subprocess.run(["git", "-C", root, "fetch", "-q", "origin", BRANCH], capture_output=True)
    parent = None
    for ref in (f"origin/{BRANCH}", BRANCH):
        r = subprocess.run(["git", "-C", root, "rev-parse", "--verify", "-q", ref], capture_output=True, text=True)
        if r.returncode == 0:
            parent = r.stdout.strip()
            break
    entries = ls_tree(parent) if parent else {}

    entries[target] = ("040000", "tree", git("-C", root, "rev-parse", f"HEAD:{src}"))
    for name, entry in ls_tree("HEAD:pages").items():
        entries[name] = entry

    mktree = "".join(f"{m} {t} {h}\t{n}\n" for n, (m, t, h) in sorted(entries.items()))
    tree = git("-C", root, "mktree", input=mktree)
    if parent and git("-C", root, "rev-parse", f"{parent}^{{tree}}") == tree:
        print("gh-pages ya está al día.")
    else:
        rev = git("-C", root, "rev-parse", "--short", "HEAD")
        ident = []
        for key, fmt in (("user.name", "%an"), ("user.email", "%ae")):
            if subprocess.run(["git", "-C", root, "config", key], capture_output=True).returncode != 0:
                ident += ["-c", f"{key}={git('-C', root, 'log', '-1', f'--format={fmt}')}"]
        cmd = [*ident, "-C", root, "commit-tree", tree, "-m", f"Publicar {target} desde {src} ({rev})"]
        if parent:
            cmd += ["-p", parent]
        commit = git(*cmd)
        git("-C", root, "update-ref", f"refs/heads/{BRANCH}", commit)
        print(f"gh-pages -> {commit[:7]}: {target}/ = {src} @ {rev}")

    if args.push:
        git("-C", root, "push", "origin", BRANCH)
        print("Subido a origin/gh-pages.")


if __name__ == "__main__":
    main()
