#Latest ubuntu LTS
FROM ubuntu:22.04

# Install required packages
RUN apt-get update \
    && apt-get install -y gnupg2 wget vim 

# Add PostgreSQL Apt repository
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt jammy-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
    && curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg

# Install PostgreSQL client from the PostgreSQL Apt repository
RUN apt-get update \
    && apt-get install -y postgresql-client-16 \
    && apt-get clean

# Create a directory for entrypoint and other files
WORKDIR /app

# Copy entrypoint script into the container
COPY entrypoint.sh entrypoint.sh

# Set script to executable
RUN chmod +x ./entrypoint.sh

# Set the script as the entrypoint
ENTRYPOINT ["./entrypoint.sh"]