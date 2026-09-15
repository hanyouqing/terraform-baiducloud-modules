output "vpc_id" { value = module.vpc.vpc_id }
output "private_subnet_ids" { value = module.vpc.private_subnet_ids }
output "nat_gateway_id" { value = module.vpc.nat_gateway_id }
output "nat_snat_eips" { value = module.vpc.nat_snat_eips }
