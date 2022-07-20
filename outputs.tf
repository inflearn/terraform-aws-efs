output "id" {
  value = aws_efs_file_system.this.id
}

output "arn" {
  value = aws_efs_file_system.this.arn
}

output "access_point_ids" {
  value = [for acp in aws_efs_access_point.this : acp.id]
}
