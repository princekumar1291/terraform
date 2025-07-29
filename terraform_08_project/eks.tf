module "eks" {
  # Use the official terraform-aws-modules EKS module from the Terraform Registry
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  # Basic EKS cluster information
  name               = local.name                  # Name of the EKS cluster
  kubernetes_version = "1.33"                     # Kubernetes version for the control plane

  # Networking options for the EKS control plane
  endpoint_public_access = true                   # Enable public access to the EKS API endpoint
  enable_cluster_creator_admin_permissions = true # Automatically assign cluster-admin to the Terraform IAM user/role

  # Networking configuration
  vpc_id     = module.vpc.vpc_id                  # VPC where the EKS cluster will be deployed
  subnet_ids = module.vpc.private_subnets         # Subnets for worker nodes
  control_plane_subnet_ids = module.vpc.intra_subnets  # Subnets for EKS control plane (intra/internal only)

  enable_irsa = true                             # Enable IAM roles for service accounts


  # EKS Cluster Add-ons - AWS managed components
  addons = {
    coredns = {}                                   # CoreDNS for internal DNS resolution in the cluster

    vpc-cni = {                                    # VPC CNI plugin for Kubernetes networking
      before_compute = true                        # Ensures this add-on is installed before nodes join
    }

    kube-proxy = {}                                # Manages iptables/IPVS rules for services

    eks-pod-identity-agent = {                     # Enables IAM Roles for Service Accounts (IRSA)
      before_compute = true                        # Must be ready before nodegroups to support IRSA
    }

    aws-ebs-csi-driver = {}                        # CSI driver for dynamic provisioning of EBS volumes
  }

  # EKS Managed Node Group(s) - EC2 workers managed by EKS
  eks_managed_node_groups = {
    my-cluster-node-group = {
      instance_types = ["t2.micro"]               # EC2 instance type used for the node group
      min_size       = 1                          # Minimum number of nodes
      max_size       = 3                          # Maximum number of nodes (autoscaling range)
      desired_size   = 2                          # Desired number of nodes when cluster launches
      capacity_type  = "ON_DEMAND"                # "ON_DEMAND" or "SPOT" pricing
      disk_size      = 8                          # EBS volume size (in GB) attached to each node

      labels = {                                  # Custom Kubernetes labels for the nodes
        nodegroup   = "example"
        environment = local.env
      }
    }
  }

  # Tags applied to all AWS resources created by this module
  tags = {
    Terraform   = "true"
    Environment = local.env
  }
}
