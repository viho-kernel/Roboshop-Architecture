locals {
  public_subnet   = join(",", module.vpc.public_subnet)
  private_subnet  = join(",", module.vpc.private_subnet)
  database_subnet = join(",", module.vpc.database_subnet)
}