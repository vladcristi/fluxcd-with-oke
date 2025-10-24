# output "bastion" {
#   value = "%{if var.create_bastion}${module.oke.bastion_public_ip}%{else}bastion host not created.%{endif}"
# }

# output "operator" {
#   value = "%{if var.create_operator}${module.oke.operator_private_ip}%{else}operator host not created.%{endif}"
# }

# output "ssh_to_operator" {
#   value = "%{if var.create_operator && var.create_bastion}${module.oke.ssh_to_operator}%{else}bastion and operator hosts not created.%{endif}"
# }