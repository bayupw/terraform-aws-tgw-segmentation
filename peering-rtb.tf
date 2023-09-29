# peering rtb, no static routes as it will be propagated from VPC attachments
resource "aws_ec2_transit_gateway_route_table" "peering" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  tags = merge(var.tags,{ Name = "peering-tgw-rtb" })
}