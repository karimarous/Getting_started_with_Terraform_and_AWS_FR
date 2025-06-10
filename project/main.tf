locals {
    env = terraform.workspace
    sg_ingress_rules = { for idx, rule in csvdecode(file("./sg_rules.csv")) : idx => rule if rule["rule_type"] == "ingress" }
    sg_egress_rules = { for idx, rule in csvdecode(file("./sg_rules.csv")) : idx => rule if rule["rule_type"] == "egress" }
}

module "network_dev" {
    count = local.env == "dev" ? 1 : 0

    source = "./modules/vpc"
    env = local.env
    vpc_name = var.vpc_name
    cidr_block = var.cidr_vpc
    env_subnets_caracteristics = var.env_subnets_caracteristics.dev
    sg_ingress_rules = local.sg_ingress_rules
    sg_egress_rules = local.sg_egress_rules
}

module "network_prod" {
    count = local.env == "prod" ? 1 : 0

    source = "./modules/vpc"
    env = local.env
    vpc_name = var.vpc_name
    cidr_block = var.cidr_vpc
    env_subnets_caracteristics = var.env_subnets_caracteristics.prod
    sg_ingress_rules = local.sg_ingress_rules
    sg_egress_rules = local.sg_egress_rules
}