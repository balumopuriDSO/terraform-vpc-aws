module "alb" {
  source = "terraform-aws-modules/alb/aws"
   internal = true


 #expense-dev-app-alb
  name    = "${var.project_name}-${var.environment}-app-alb"
  vpc_id  = data.aws_subnet.public.vpc_id
  subnets = local.subnet_ids
  create_security_group = true
 

 
  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-app-alb"
    }

  )
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = module.alb.arn
  port              = "80"
  protocol          = "HTTP"
 

   default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, I am from backend APP ALB</h1>"
      status_code  = "200"
    }
  }
}