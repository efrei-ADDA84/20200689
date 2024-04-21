output "resource_group_name" {
  value = var.azure_resource_group_name
}

output "public_ip_address" {
  value = azurerm_public_ip.publicip.ip_address
}

output "private_key" {
  value     = tls_private_key.main_ssh_key.private_key_pem
  sensitive = true
}