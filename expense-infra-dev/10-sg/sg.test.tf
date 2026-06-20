module "mysql_sg" {
    source = "git::https://github.com/balumopuriDSO/terraform-vpc-aws.git//Terraform-aws-securitygroup/aws-sg-module?ref=61edddd9ffecf2a07c59bff5c1e5fba1e8f0832b"
    project_name = var.project_name
    environment = var.environment
    sg_name = "mysql"
    sg_description = var.sg_description
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}


module "backend_sg" {
    source = "git::https://github.com/balumopuriDSO/terraform-vpc-aws.git//Terraform-aws-securitygroup/aws-sg-module?ref=61edddd9ffecf2a07c59bff5c1e5fba1e8f0832b"
    project_name = var.project_name
    environment = var.environment
    sg_name = "backend"
    sg_description = "created for backend instances in expense dev"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "frontend_sg" {
    source = "git::https://github.com/balumopuriDSO/terraform-vpc-aws.git//Terraform-aws-securitygroup/aws-sg-module?ref=61edddd9ffecf2a07c59bff5c1e5fba1e8f0832b"
    project_name = var.project_name
    environment = var.environment
    sg_name = "frontend"
    sg_description = "created for frontend instances in expense dev"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "bastion_sg" {
    source = "git::https://github.com/balumopuriDSO/terraform-vpc-aws.git//Terraform-aws-securitygroup/aws-sg-module?ref=61edddd9ffecf2a07c59bff5c1e5fba1e8f0832b"
    project_name = var.project_name
    environment = var.environment
    sg_name = "bastion"
    sg_description = "created for bastion instances in expense dev"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "app_alb_sg" {
    source = "git::https://github.com/balumopuriDSO/terraform-vpc-aws.git//Terraform-aws-securitygroup/aws-sg-module?ref=61edddd9ffecf2a07c59bff5c1e5fba1e8f0832b"
    project_name = var.project_name
    environment = var.environment
    sg_name = "app-alb"
    sg_description = "created for backend alb in expense dev"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}

# A
resource "aws_security_group_rule" "app_alb_bastion" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    source_security_group_id = module.bastion_sg.sg_id
    security_group_id = module.app_alb_sg.sg_id
  
}

resource "aws_security_group_rule" "bastion_public" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = module.bastion_sg.sg_id
  
}
