<<<<<<< HEAD
resource "aws_opensearch_domain" "test-opensearch" {
  domain_name    = "test-opensearch"
  engine_version = "OpenSearch_1.2"

  cluster_config {
    dedicated_master_enabled = false
    # zone_awareness_enabled = true
    # availability_zone_count = 1
    instance_type = "t3.small.search"
    instance_count = 1
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
    }


  vpc_options {
    subnet_ids = [aws_subnet.subnet_private1.id]
  }

}

resource "aws_elasticsearch_domain_policy" "os-policy" {
    domain_name = "test-opensearch"

    access_policies = <<POLICIES
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "AWS": [
              "*"
            ]
          },
          "Action": [
            "es:*"
          ],
          "Resource": "aws_elasticsearch_domain.test-opensearch.arn/*"
        }
      ]
    }
    POLICIES
}
=======
resource "aws_opensearch_domain" "test-opensearch" {
  domain_name    = "test-opensearch"
  engine_version = "OpenSearch_1.2"

  cluster_config {
    dedicated_master_enabled = false
    # zone_awareness_enabled = true
    # availability_zone_count = 1
    instance_type = "t3.small.search"
    instance_count = 1
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
    }


  vpc_options {
    subnet_ids = [aws_subnet.subnet_private1.id]
  }

}

resource "aws_elasticsearch_domain_policy" "os-policy" {
    domain_name = "test-opensearch"

    access_policies = <<POLICIES
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "AWS": [
              "*"
            ]
          },
          "Action": [
            "es:*"
          ],
          "Resource": "aws_elasticsearch_domain.test-opensearch.arn/*"
        }
      ]
    }
    POLICIES
    }

>>>>>>> 827a842c7637945d947d2e7b243682db02915f05
