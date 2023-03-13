# Create kv-policy policy in the root namespace
# resource "vault_policy" "group-policy" {
#   name   = "group-policy"
#   policy = file("group-policy.hcl")
# }


# Create kv-policy with variable for Identity Group ID
# resource "vault_policy" "group-policy" {
#   depends_on = [
#     vault_identity_group.group.id
#   ]

#   name   = "group-policy"
#   policy = <<EOF
# path "group-kv/data/training/{{identity.groups.ids.${vault_identity_group.group.id}.name}}/*" {
#   capabilities = ["create", "update", "read", "delete", "list"]
# }

# path "group-kv/metadata/*" {
#   capabilities = ["list"]
# }
# EOF
# }

data "vault_policy_document" "group" {
  rule {
    path         = "group-kv/data/training/{{identity.groups.ids.${vault_identity_group.group.id}.name}}/*"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = "allow all on secrets"
  }

  rule {
    path         = "group-kv/metadata/*"
    capabilities = ["list"]
    description  = "allow listing metadata"
  }

}

resource "vault_policy" "group-policy" {
  name   = "group-policy"
  policy = data.vault_policy_document.group.hcl
}