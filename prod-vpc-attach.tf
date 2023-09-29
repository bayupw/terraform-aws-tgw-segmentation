# attach to hub tgw
resource "aws_ec2_transit_gateway_vpc_attachment" "env_prod" {
  subnet_ids                                      = var.subnet_ids
  transit_gateway_id                              = aws_ec2_transit_gateway.hub.id
  vpc_id                                          = var.prod_vpc_id
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  appliance_mode_support                          = "disable"
}

# associate to environment rtb
resource "aws_ec2_transit_gateway_route_table_association" "env_prod" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.env_prod.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.env_prod.id
}

# Propagate to kong rtb
resource "aws_ec2_transit_gateway_route_table_propagation" "kong_prod" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.env_prod.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.kong-prod.id
}

# Propagate to egress rtb
resource "aws_ec2_transit_gateway_route_table_propagation" "egress_prod" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.env_prod.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress-prod.id
}

# Propagate to peering rtb
resource "aws_ec2_transit_gateway_route_table_propagation" "peering" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.env_prod.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.peering.id
}
