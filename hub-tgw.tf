resource "aws_ec2_transit_gateway" "hub" {
  description                     = var.name
  amazon_side_asn                 = var.asn
  dns_support                     = "enable"
  vpn_ecmp_support                = "enable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  multicast_support               = "disable"
  transit_gateway_cidr_blocks     = null

  tags = merge(var.tags,{ Name = var.name })
}