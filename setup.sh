#!/usr/bin/env bash
set -euo pipefail
SANA_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$SANA_DIR"
if command -v python3.11 >/dev/null 2>&1; then
  exec python3.11 scripts/manage.py setup "$@"
fi
if command -v python3 >/dev/null 2>&1 && python3 -c 'import sys; sys.exit(sys.version_info[:2] != (3, 11))'; then
  exec python3 scripts/manage.py setup "$@"
fi
printf '%s\n' 'Python 3.11 is required. Install it, then run: bash setup.sh' >&2
exit 1
