#!/bin/sh

# Vault configuration
VAULT_ADDR="http://vault:8200"
VAULT_TOKEN="${VAULT_TOKEN}"
SECRET_PATH="secret/data/project1"

# Verify token exists
if [ -z "$VAULT_TOKEN" ]; then
    echo "Error: VAULT_TOKEN is not set."
    exit 1
fi

echo "Retrieving secrets from Vault..."

SECRETS=$(curl -s \
    -H "X-Vault-Token: $VAULT_TOKEN" \
    "$VAULT_ADDR/v1/$SECRET_PATH")

if echo "$SECRETS" | grep -q "\"errors\""; then
    echo "Failed to retrieve secrets."
    echo "$SECRETS"
    exit 1
fi

cat > .env <<EOF
$(echo "$SECRETS" | jq -r '.data.data | to_entries | .[] | "\(.key)=\(.value)"')
EOF

echo ".env file created successfully."
