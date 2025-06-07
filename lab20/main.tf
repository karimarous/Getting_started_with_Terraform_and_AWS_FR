module "ec2" {
  source = "./modules/ec2"
  env = local.env
  sg_name = var.sg_name
  sg_description = var.sg_description
  sg_ingress_rules = var.sg_ingress_rules
  sg_egress_rules = var.sg_egress_rules
  ami_owner = var.ami_owner
  ami_name = var.ami_name
  ami_virtualization_type = var.ami_virtualization_type
  instance_type = var.instance_type
  instance_name = var.instance_name
}