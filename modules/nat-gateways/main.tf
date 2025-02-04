resource "aws_eip" "natgw" {
  count = var.subnet_count
  domain = "vpc"
}

resource "aws_nat_gateway" "natgw" {
  count = var.subnet_count

  allocation_id = element(aws_eip.natgw.*.id, count.index)
  subnet_id     = element(var.subnet_ids, count.index)
#  tags          = merge(var.tags, lookup(var.tags_for_resource, "aws_nat_gateway", {}))

  tags = {
    Name      = "aws_nat_gateway ${count.index + 1}"
    managedBy = "Terraform"
    owner     = "Shashi Singh"
    createdBy = "Project VPC"
  }
}
