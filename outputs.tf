# Outputs

output "vanguard_vpc" {
  value = aws_vpc.vanguard_vpc.id
}

output "subnet_1_id" {
  value = aws_subnet.subnet_1.id
}

output "subnet_2_id" {
  value = aws_subnet.subnet_2.id
}

# Outputs
output "instances_in_subnet_1_ids" {
  value = aws_instance.instances_in_subnet_1[*].id
}

output "instances_in_subnet_2_ids" {
  value = aws_instance.instances_in_subnet_2[*].id
}