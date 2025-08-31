# Test-6-Vault - HashiCorp Vault Integration

## HashiCorp Vault Variants
- **Production Server** - Full featured, persistent storage
- **Dev Server** - Development/testing, in-memory storage

## Installation
```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vault
```

## Dev Server Setup
```bash
vault server -dev -dev-listen-address="0.0.0.0:8200"
```
**Root Token:** `hvs.ZdFfqMjq01KyPCe2eGy7vsWj`

## Configuration Steps

### 1. Enable AppRole Authentication
```bash
export VAULT_ADDR='http://0.0.0.0:8200'
vault auth enable approle
```

### 2. Create Policy
```bash
vault policy write terraform - <<EOF
path "*" {
  capabilities = ["list", "read"]
}
path "secrets/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
path "kv/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
path "secret/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
path "auth/token/create" {
  capabilities = ["create", "read", "update", "list"]
}
EOF
```

### 3. Create AppRole
```bash
vault write auth/approle/role/terraform \
    secret_id_ttl=10m \
    token_num_uses=10 \
    token_ttl=20m \
    token_max_ttl=30m \
    secret_id_num_uses=40 \
    token_policies=terraform
```

### 4. Generate Credentials
```bash
# Get Role ID (static)
vault read auth/approle/role/terraform/role-id


# Generate Secret ID (dynamic)
vault write -f auth/approle/role/terraform/secret-id
#
```

## Terraform Integration
- **Provider Configuration:** Uses AppRole authentication with role_id and secret_id
- **Secret Retrieval:** Fetches secrets from Vault KV store
- **Resource Tagging:** Uses Vault secrets in AWS resource tags
- **Security:** Credentials managed centrally in Vault, not in code