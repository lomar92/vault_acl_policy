# Generic Secrets Engine db-secret
resource "vault_mount" "kvv2" {
  path        = "db-secret"
  type        = "kv"
  options     = { version = "2" }
  description = "This is the Metadata Region Associated Secrets Engine"
}

resource "vault_kv_secret_v2" "secret" {
  mount               = vault_mount.kvv2.path
  name                = "db-secret"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      nutzername = "max",
      password   = "mustermann"
    }
  )
}


# 1st Secrets Engine for User Groups. Metadata Region Associated under path

# Create Mount Point 
resource "vault_mount" "group-kv" {
  path        = "group-kv"
  type        = "kv"
  options     = { version = "2" }
  description = "This is Group-KV based on Metadata of Identity Group"
}

resource "vault_kv_secret_v2" "group-kv" {
  mount               = vault_mount.group-kv.path
  name                = "training/berlin/db_cred"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      zip = "zap",
      foo = "bar"
    }
  )
}

# # 2nd Secrets Engine for User Groups based on Identity Group Name ID
# resource "vault_kv_secret_v2" "group-kv-2" {
#   mount               = vault_mount.group-kv.path
#   name                = "training/79d088f2-0558-c96e-1ad8-e846e2d09c61/db_cred"
#   cas                 = 1
#   delete_all_versions = true
#   data_json = jsonencode(
#     {
#       zip = "zap",
#       foo = "bar"
#     }
#   )
# }

# 3rd Secrets Engine for User Groups based on Identity Group Name, which requires policy with Identity group id
resource "vault_kv_secret_v2" "group-kv-3" {
  mount               = vault_mount.group-kv.path
  name                = "training/${var.secrets_path}/db_cred"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      zip = "zap",
      foo = "bar"
    }
  )
}