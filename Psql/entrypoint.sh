#!/usr/bin/env bash

set -Eeuo pipefail

# Check if the backup directory is provided
if [ -z "${BACKUP_DIR:-}" ]; then
    echo "Backup directory not specified. Please set the BACKUP_DIR environment variable."
    exit 1
fi

mkdir -p "$BACKUP_DIR"

# Check if the PostgreSQL host is provided
if [ -z "${PGHOST:-}" ]; then
    echo "PostgreSQL host not specified. Please set the PGHOST environment variable."
    exit 1
fi

# Check if the PostgreSQL port is provided
if [ -z "${PGPORT:-}" ]; then
    echo "PostgreSQL port not specified. Please set the PGPORT environment variable."
    exit 1
fi

# Check if the PostgreSQL user is provided
if [ -z "${PGUSER:-}" ]; then
    echo "PostgreSQL user not specified. Please set the PGUSER environment variable."
    exit 1
fi

# Check if the PostgreSQL password is provided
if [ -z "${PGPASSWORD:-}" ]; then
    echo "PostgreSQL password not specified. Please set the PGPASSWORD environment variable."
    exit 1
fi

# Loop through all connectable databases and backup each one.
databases=$(PGPASSWORD="$PGPASSWORD" psql \
    --host="$PGHOST" \
    --port="$PGPORT" \
    --username="$PGUSER" \
    --no-align \
    --tuples-only \
    --command="SELECT datname FROM pg_database WHERE datallowconn AND NOT datistemplate AND datname <> 'postgres' ORDER BY datname;")

while IFS= read -r db; do
    [ -n "$db" ] || continue
    echo "Backing up database: $db"
    filename="$BACKUP_DIR/$db-$(date +%Y%m%d%H%M%S).dump"
    PGPASSWORD="$PGPASSWORD" pg_dump \
        --host="$PGHOST" \
        --port="$PGPORT" \
        --username="$PGUSER" \
        --format=custom \
        --file="$filename" \
        --dbname="$db"
    echo "Backup completed: $filename"
done <<< "$databases"

echo "All databases backed up successfully to $BACKUP_DIR"