output "hub1-publicip" {
  value = module.crpd1.public-ip
}

output "hub2-publicip" {
  value = module.crpd2.public-ip
}

output "spoke1-publicip" {
  value = module.vmspoke1.public-ip
}

output "spoke2-publicip" {
  value = module.vmspoke2.public-ip
}

output "spoke11-publicip" {
  value = module.vmspoke11.public-ip
}

output "spoke12-publicip" {
  value = module.vmspoke12.public-ip
}