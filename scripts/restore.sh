#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: CONFIRM_RESTORE=YES $0 <backup-file.dump>" >&2
  exit 2
fi

if [[ "${CONFIRM_RESTORE:-}" != "YES" ]]; then
  echo "Refusing to restore. Set CONFIRM_RESTORE=YES after checking the target database." >&2
  exit 2
fi

backup_file="$1"
[[ -f "$backup_file" ]] || { echo "Backup file not found: $backup_file" >&2; exit 1; }

: "${PGHOST:=localhost}"
: "${PGPORT:=5432}"
: "${PGDATABASE:=backup_platform}"
: "${PGUSER:=backup_user}"
: "${PGPASSWORD:?Set PGPASSWORD before running this script}"

export PGPASSWORD
pg_restore --host "$PGHOST" --port "$PGPORT" --username "$PGUSER" \
  --dbname "$PGDATABASE" --clean --if-exists --no-owner "$backup_file"
unset PGPASSWORD

echo "Restore completed from: $backup_file"
