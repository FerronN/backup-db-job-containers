# PostgreSQL Database Backup Script

This Bash script automates the process of backing up PostgreSQL databases. It connects to a PostgreSQL server, retrieves a list of databases, and creates a backup file for each database.

## Requirements

- PostgreSQL server with databases to backup
- Environment variables:
  - `BACKUP_DIR`: Directory where backup files will be stored
  - `PGHOST`: PostgreSQL server hostname or IP address
  - `PGPORT`: PostgreSQL server port
  - `PGUSER`: PostgreSQL username with permission to access databases
  - `PGPASSWORD`: PostgreSQL user password

## Usage

1. Ensure that the required environment variables are set before running the script.
2. Execute the script to initiate the backup process.

## Script Functionality

1. Validates the presence of required environment variables:
   - `BACKUP_DIR`: Directory where backup files will be stored
   - `PGHOST`: PostgreSQL server hostname or IP address
   - `PGPORT`: PostgreSQL server port
   - `PGUSER`: PostgreSQL username with permission to access databases
   - `PGPASSWORD`: PostgreSQL user password

2. Retrieves a list of databases from the PostgreSQL server, excluding system databases (`template`, `postgres`).

3. Loops through each database and performs the following steps:
   - Creates a backup filename using the database name and current timestamp.
   - Initiates a `pg_dump` command to create a backup file for the database in custom format.
   - Saves the backup file in the specified backup directory.

4. Prints status messages for each database backup.

5. Outputs a completion message indicating the successful backup of all databases.

## Example Usage

### Docker Example

```
docker run \
  -e BACKUP_DIR=/path/to/backup/directory \
  -e PGHOST=postgresql-server \
  -e PGPORT=5432 \
  -e PGUSER=backup_user \
  -e PGPASSWORD=backup_password \
  your-image-name
```

### Kubernetes Example

```
apiVersion: batch/v1
kind: CronJob
metadata:
  name: postgres-database-backup
spec:
  schedule: "0 4 * * *" # Run daily at 4 AM
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: backup-container
            image: your-image-name
            env:
            - name: BACKUP_DIR
              value: /path/to/backup/directory
            - name: PGHOST
              value: postgresql-server
            - name: PGPORT
              value: "5432"
            - name: PGUSER
              value: backup_user
            - name: PGPASSWORD
              value: backup_password
          restartPolicy: OnFailure

```

## Access Required for PostgreSQL User
Access Required for PostgreSQL User
The backup_user specified in the script requires the following access:

Read access to all databases to retrieve their names and data.
Access to initiate pg_dump command to create backups.