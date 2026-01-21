# Dockerfile.postgres
FROM postgres:18-bookworm

RUN apt-get update && apt-get install -y \
    build-essential git postgresql-server-dev-18 ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# pgvector
RUN cd /tmp \
    && git clone --branch v0.8.1 https://github.com/pgvector/pgvector.git \
    && cd pgvector && make && make install \
    && rm -rf /tmp/pgvector

# pg_textsearch
RUN cd /tmp \
    && git clone https://github.com/timescale/pg_textsearch.git \
    && cd pg_textsearch && make && make install \
    && rm -rf /tmp/pg_textsearch

RUN apt-get purge -y --auto-remove build-essential git postgresql-server-dev-18 \
    && rm -rf /var/lib/apt/lists/*
