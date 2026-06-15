# output "azs_info" {
#     value = data.aws_availability_zones.available.names
# }

# output "subnet_info"{
#     value = aws_subnet.public
# }

output "vpc_id" {
  value = aws_vpc.main.id
}
