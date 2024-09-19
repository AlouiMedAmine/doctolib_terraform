##############################
# Security Groups
##############################

# 1. Source security group - From where traffic is allowed
# 2. Compliant security group
#   2.1 Security group rule
# 3. Non-compliant security group
#   3.1 Security group rule

resource "aws_security_group" "source" {
  name        = "source-sg"
  description = "SG from where connections are allowed into the DB"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group" "compliant" {
  name        = "compliant-sg"
  description = "Compliant security group"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group" "non_compliant" {
  name        = "non-compliant-sg"
  description = "Non-compliant security group"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.non_compliant.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "db" {
  security_group_id            = aws_security_group.compliant.id
  referenced_security_group_id = aws_security_group.source.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}


##################################################
## Only for test to connect to database from external
/*resource "aws_vpc_security_group_ingress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.compliant.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}*/
####################################################

