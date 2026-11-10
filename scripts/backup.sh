#!/usr/bin/env bash
set -euo pipefail

: "${PGHOST:=localhost}"
: "${PGPORT:=5432}"
: "${PGDATABASE:=backup_platform}"
: "${PGUSER:=backup_user}"
: "${PGPASSWORD:?Set PGPASSWORD before running this script}"

BACKUP_DIR="${BACKUP_DIR:-backups}"
mkdir -p "$BACKUP_DIR"

timestamp="$(date -u +%Y%m%dT%H%M%SZ)"
output_file="${BACKUP_DIR}/${PGDATABASE}_${timestamp}.dump"

export PGPASSWORD
pg_dump --host "$PGHOST" --port "$PGPORT" --username "$PGUSER" \
  --dbname "$PGDATABASE" --format=custom --no-owner --file "$output_file"
unset PGPASSWORD

echo "Backup created: $output_file"
