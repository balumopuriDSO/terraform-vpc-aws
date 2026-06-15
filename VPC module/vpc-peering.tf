resource "aws_vpc_peering_connection" "main" {
    count = var.is_peering_enabled ? 1 : 0
    # peer_owner_id = data.aws_caller_identity.current.account_id
    peer_vpc_id = local.default_vpc_id
    vpc_id = aws_vpc.main.id
    auto_accept = true

    tags = merge(
        var.common_tags,
        var.vpc_peering_tags,
        {
        "Name" = "${local.resource_name}-default"
        }
    )
  
}