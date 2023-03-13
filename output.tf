output "group_id" {
  value = vault_identity_group.group.id
}

output "group_name" {
  value = vault_identity_group.group.name
}

output "group_member_entity_ids" {
  value = vault_identity_group.group.member_entity_ids
}
