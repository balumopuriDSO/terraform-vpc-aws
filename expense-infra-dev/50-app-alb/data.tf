data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}

data "aws_subnet" "public" {
  id = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]
}
