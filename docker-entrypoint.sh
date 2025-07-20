#!/bin/bash

echo "🔄 Fetching secrets from Infisical..."
export $(infisical export --domain "$VAULT_URL" --projectId "$VAULT_PROJECT_ID" --env "$VAULT_ENV" --format=dotenv | xargs)

echo "✅ Secrets loaded: DB_USER=$DB_USER, DB_NAME=$DB_NAME"

export POSTGRES_USER=${DB_USER:-postgres}
export POSTGRES_PASSWORD=${DB_PASS:-postgres}
export POSTGRES_DB=${DB_NAME:-doora_db}

echo "🚀 Starting PostgreSQL..."
exec docker-entrypoint.sh postgres
