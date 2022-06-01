resource "aws_elasticache_subnet_group" "project4_cache" {
  name       = "final-project4-cache-subnet"
  subnet_ids = [aws_subnet.subnet_private1.id, aws_subnet.subnet_private2.id]
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "final"
  replication_group_description = "reserve"

  engine = "redis"
  engine_version = "6.x"

  node_type            = "cache.t3.micro"
  port                 = 6379
  parameter_group_name = "default.redis6.x.cluster.on"
 
  snapshot_retention_limit = 2
  snapshot_window          = "00:00-05:00"
 
  subnet_group_name = aws_elasticache_subnet_group.project4_cache.name
  security_group_ids = [aws_security_group.final_project4_private_sg.id]
 
  automatic_failover_enabled = true
 
  number_cache_clusters = 2
  
}