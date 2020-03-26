#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE peertube;
    CREATE USER peertube WITH PASSWORD 'peertube';  
    GRANT ALL PRIVILEGES ON DATABASE peertube TO peertube;
    GRANT USAGE ON SCHEMA public TO peertube;
EOSQL


psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "peertube" <<-EOSQL
    CREATE EXTENSION pg_trgm;
    CREATE EXTENSION unaccent;
EOSQL