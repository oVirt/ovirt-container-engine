#!/bin/bash
sed -i $PGDATA/postgresql.conf -e "s/^max_connections .*$/max_connections = $MAX_CONNECTIONS/"
