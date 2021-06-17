@Library(value="kids-first/aws-infra-jenkins-shared-libraries@feature/open_port", changelog=false) _
aws_infra_ec2_module {
    projectName          = "gic-instance"
    environments         = "prd"
    ami                  = "ami-0adf32ccce55f2fc0"
    open_port            = "443"
    additional_ports     = "8080"
    domain_external      = "d3b.io"
    domain_internal      = "d3b.io"
    ec2_instance_type    = "m5.8xlarge"
    root_volume_size     = "100"
    volume_size          = "100"
    module_branch        = "feature/test-network-module"
}
