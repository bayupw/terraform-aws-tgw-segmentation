# TGW rtb
resource "aws_ec2_transit_gateway_route_table" "env_prod" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  tags = merge(var.tags,{ Name = "env-prod-tgw-rtb" })
}

# Blackhole static routes
resource "aws_ec2_transit_gateway_route" "tgw_blackhole_static_routes" {
  for_each = local.tgw_rfc1918_routes
  
  destination_cidr_block = each.key
  blackhole = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.env_prod.id
}

# Azure routes
resource "aws_ec2_transit_gateway_route" "azure_static_routes" { 
  destination_cidr_block = var.azure_cidr_block
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.env_prod.id
}

# onprem routes
resource "aws_ec2_transit_gateway_route" "onprem_static_routes" { 
  destination_cidr_block = var.onprem_cidr_block
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.env_prod.id
}
