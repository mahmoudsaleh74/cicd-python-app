module "vpc" {
  source = "./modules/vpc"
  vpc_name = "my vpc"
  cidr_block = "10.0.0.0/16"
}

module "public_subnets" {
  source = "./modules/subnet"
  vpc_id = module.vpc.vpc_id
 cidr_blocks = {
    "public1" = {
      cidr_block        = "10.0.10.0/24"
      availability_zone = "us-east-1a"
      name              = "Public_Subnet_1"
    },
    "public2" = {
      cidr_block        = "10.0.20.0/24"
      availability_zone = "us-east-1b"
      name              = "Public_Subnet_2"
    }
  }
  
}
module "igw" {
  source = "./modules/igw"
  vpc_id = module.vpc.vpc_id
  igw_name = "my gw" 
}


module "route_able" {
  source = "./modules/routetable"
  vpc_id = module.vpc.vpc_id
  cidr_block = "0.0.0.0/0"
  igw_id = module.igw.igw_id
  rt_name = "my rt"
  public_subnet_ids = module.public_subnets.subnet_ids
}

module "sg" {
  source = "./modules/securitygroup"
  vpc_id = module.vpc.vpc_id
  Security_Group_Name = "my sg"
  
}

module "eks" {
  source = "./modules/eks"
  cluster_name="my-cluster"
  public_subnet_ids=module.public_subnets.subnet_ids
  worker_template="my_template"
  node_group_name="my-node-group"
  disk_size="20"
  instance_type="t2.small"
  security_group=module.sg.sg_id
  scaling=[1,2,1]
}

module "ec2" {
  source = "./modules/ec2"
  depends_on= [module.eks]
  key_pair_name="kamen"
  instance_type="t2.micro"
  availability_zone="us-east-1a"
  subnet_id=module.public_subnets.subnet_ids[0]
  sg=module.sg.sg_id
  volume_size="8"
  instance_name="my instance"
  eks_profile_name=module.eks.eks_profile_name
}

module "ecr" {
  source = "./modules/ecr"
  repository_name="kameeeeenrepoo"
}

