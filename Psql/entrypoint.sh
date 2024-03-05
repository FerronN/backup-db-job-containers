#!/bin/bash

# Check if the backup directory is provided
if [ -z "$BACKUP_DIR" ]; then
    echo "Backup directory not specified. Please set the BACKUP_DIR environment variable."
    exit 1
fi

# Check if the PostgreSQL host is provided
if [ -z "$PGHOST" ]; then
    echo "PostgreSQL host not specified. Please set the PGHOST environment variable."
    exit 1
fi

# Check if the PostgreSQL port is provided
if [ -z "$PGPORT" ]; then
    echo "PostgreSQL port not specified. Please set the PGPORT environment variable."
    exit 1
fi

# Check if the PostgreSQL user is provided
if [ -z "$PGUSER" ]; then
    echo "PostgreSQL user not specified. Please set the PGUSER environment variable."
    exit 1
fi

# Check if the PostgreSQL password is provided
if [ -z "$PGPASSWORD" ]; then
    echo "PostgreSQL password not specified. Please set the PGPASSWORD environment variable."
    exit 1
fi

# Loop through all databases and backup each one
databases=$(PGPASSWORD="$PGPASSWORD" psql -lqt -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" | cut -d \| -f 1 | grep -v -E '^\s*template|postgres')

for db in $databases; do
    echo "Backing up database: $db"
    filename="$BACKUP_DIR/$db-$(date +%Y%m%d%H%M%S).sql"
    PGPASSWORD="$PGPASSWORD" pg_dump -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -Fc "$db" > "$filename"
    echo "Backup completed: $filename"
done

echo "All databases backed up successfully to $BACKUP_DIR"