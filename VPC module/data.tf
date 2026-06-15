data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_vpc" "default" {
   default = true
}

data "aws_route_tables" "main" {
  vpc_id = local.default_vpc_id
    filter {
        name = "vpc-id"
        values = ["true"]
    }
}