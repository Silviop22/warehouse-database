# Use the official PostgreSQL image
FROM postgres:15

# Set environment variables for PostgreSQL
ENV POSTGRES_USER=warehouse
ENV POSTGRES_PASSWORD=warehouse
ENV POSTGRES_DB=warehouse

# Copy the init.sql script into the Docker entrypoint directory
COPY init.sql /docker-entrypoint-initdb.d/

# Copy custom PostgreSQL configuration files into the container
COPY postgresql.conf /etc/postgresql/postgresql.conf.sample
COPY pg_hba.conf /etc/postgresql/pg_hba.conf

# Expose PostgreSQL port
EXPOSE 5432

# Start PostgreSQL with the custom configuration file
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf.sample"]

