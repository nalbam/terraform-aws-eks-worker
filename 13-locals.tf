# locals

locals {
  account_id = data.aws_caller_identity.current.account_id
}

locals {
  user_data = <<EOF
#!/bin/bash -xe
/etc/eks/bootstrap.sh \
  --apiserver-endpoint '${var.config.cluster_endpoint}' \
  --b64-cluster-ca '${var.config.cluster_certificate_authority}' \
  '${var.config.cluster_name}'
EOF

}
