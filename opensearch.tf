resource "aws_opensearch_domain" "test2-opensearch" {
  domain_name    = "test2-opensearch"
  engine_version = "OpenSearch_1.2"

  cluster_config {
    dedicated_master_enabled = false
    # zone_awareness_enabled = true
    # availability_zone_count = 1
    instance_type = "t3.small.search"
    instance_count = 1
  }

  auto_tune_options {
    desired_state = "DISABLED"
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
    }


/*
  vpc_options {
    subnet_ids = [aws_subnet.subnet_private1.id]
  }

  /


advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = true
    master_user_options {
      # master_user_name     = "admin"
      # master_user_password = "Aa!12341234"
      # You can also use IAM role/user ARN
      master_user_arn = "arn:aws:iam::351954682436:user/terraform"
    }
}




  encrypt_at_rest {
    enabled = true
  }

  domain_endpoint_options {
   # enforce_https       = false
   tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

node_to_node_encryption {
    enabled = true
  }

  access_policies = <<POLICIES

   {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::351954682436:user/terraform"
      },
      "Action": "es:ESHttpGet",
      "Resource": "arn:aws:es:ap-northeast-2:351954682436:domain/test-1/"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": ""
      },
      "Action": "es:",
      "Resource": "arn:aws:es:ap-northeast-2:351954682436:domain/test-1/",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": "218.235.89.144/32"
        }
      }
    }
  ]
}
    POLICIES

    }


/

resource "aws_iam_service_linked_role" "es" {
    aws_service_name = "es.amazonaws.com"
    description      = "Allows Amazon ES to manage AWS resources for a domain on your behalf."
}

*/