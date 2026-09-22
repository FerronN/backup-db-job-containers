#Latest ubuntu LTS
FROM ubuntu:22.04

# Install required packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates gnupg2 curl \
    && rm -rf /var/lib/apt/lists/*

# Add PostgreSQL Apt repository
RUN sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt jammy-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
    && curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg

# Install PostgreSQL client from the PostgreSQL Apt repository
RUN apt-get update \
    && apt-get install -y --no-install-recommends postgresql-client-16 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a directory for entrypoint and other files
WORKDIR /app

# Copy entrypoint script into the container
COPY entrypoint.sh entrypoint.sh

# Set script to executable
RUN chmod +x ./entrypoint.sh

# Set the script as the entrypoint
ENTRYPOINT ["./entrypoint.sh"]