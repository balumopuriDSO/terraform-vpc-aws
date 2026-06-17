locals {
  subnet_ids = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
}