#Latest ubuntu LTS
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y postgresql-client && apt-get clean

# Create a directory for entrypoint and other files
WORKDIR /app

# Copy entrypoint script into the container
COPY entrypoint.sh entrypoint.sh

# Set the script as the entrypoint
ENTRYPOINT ["entrypoint.sh"]