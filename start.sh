#!/usr/bin/env bash
set -euo pipefail
SANA_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$SANA_DIR"
bash setup.sh
exec .venv/bin/python -X utf8 scripts/manage.py run "$@"
