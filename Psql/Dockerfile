#Latest ubuntu LTS
FROM ubuntu:22.04

# Install required packages
RUN apt-get update \
    && apt-get install -y gnupg2 wget vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add PostgreSQL Apt repository
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/$(lsb_release -cs)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Install PostgreSQL client from the PostgreSQL Apt repository
RUN apt-get update \
    && apt-get install -y postgresql-client \
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