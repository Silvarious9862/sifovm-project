#!/usr/bin/env python3
import argparse
import re
from pathlib import Path

BDF_EXT = '.bdf'
BSF_EXT = '.bsf'


def read_text(path: Path) -> str:
    return path.read_text(encoding='utf-8', errors='ignore')


def write_text(path: Path, text: str) -> None:
    path.write_text(text, encoding='utf-8', newline='')


def collect_bdf_entities(src: Path):
    mapping = {}
    for f in sorted(src.rglob(f'*{BDF_EXT}')):
        stem = f.stem
        if stem in mapping:
            raise SystemExit(
                f'Duplicate BDF basename found: {stem}\n{mapping[stem]}\n{f}\n'
                'Rename one manually first.'
            )
        mapping[stem] = f
    return mapping


def replace_attr(text: str, tag: str, attr: str, old: str, new: str) -> str:
    pat = re.compile(rf'(<{tag}[^>]*\b{attr}=")({re.escape(old)})(")')
    return pat.sub(rf'\1{new}\3', text)


def replace_file_ref(text: str, ext: str, old: str, new: str) -> str:
    pat = re.compile(rf'((?:FILE\s+"|[^A-Za-z0-9_]))({re.escape(old)})(\.{re.escape(ext)}\b)')
    return pat.sub(lambda m: f'{m.group(1)}{new}{m.group(3)}', text)


def rename_content(text: str, old: str, new: str) -> str:
    out = text

    for tag, attr in [
        ('block', 'symbol'),
        ('block', 'name'),
        ('symbol', 'name'),
        ('instance', 'symbol'),
        ('blockdef', 'name'),
        ('design', 'name'),
        ('header', 'name'),
    ]:
        out = replace_attr(out, tag, attr, old, new)

    out = replace_file_ref(out, 'bdf', old, new)
    out = replace_file_ref(out, 'bsf', old, new)
    return out


def process(src: Path, dst: Path, prefix: str, dry_run: bool):
    entity_files = collect_bdf_entities(src)
    rename_map = {name: f'{prefix}{name}' for name in entity_files}

    if dry_run:
        print('Planned renames:')
        for old, new in rename_map.items():
            print(f'  {old} -> {new}')
        return

    dst.mkdir(parents=True, exist_ok=True)

    for in_path in src.rglob('*'):
        rel = in_path.relative_to(src)
        out_path = dst / rel

        if in_path.is_dir():
            out_path.mkdir(parents=True, exist_ok=True)
            continue

        if in_path.suffix.lower() in (BDF_EXT, BSF_EXT) and in_path.stem in rename_map:
            out_path = out_path.with_name(rename_map[in_path.stem] + in_path.suffix)

        if in_path.suffix.lower() in (BDF_EXT, BSF_EXT):
            text = read_text(in_path)
            for old, new in rename_map.items():
                text = rename_content(text, old, new)
            write_text(out_path, text)
        else:
            out_path.write_bytes(in_path.read_bytes())

    write_text(
        dst / 'rename_map.txt',
        '\n'.join(f'{o} -> {n}' for o, n in sorted(rename_map.items())) + '\n'
    )
    print(f'Done. Output: {dst}')


if __name__ == '__main__':
    ap = argparse.ArgumentParser(
        description='Mass-rename Quartus BDF/BSF entity basenames with a prefix.'
    )
    ap.add_argument('src')
    ap.add_argument('dst')
    ap.add_argument('--prefix', required=True)
    ap.add_argument('--dry-run', action='store_true')
    args = ap.parse_args()

    src = Path(args.src).resolve()
    dst = Path(args.dst).resolve()

    if not src.exists() or not src.is_dir():
        raise SystemExit(f'Source folder not found: {src}')

    process(src, dst, args.prefix, args.dry_run)