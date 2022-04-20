resource "aws_efs_file_system" "this" {
  tags = merge(var.tags, { Name = "${var.prefix}-efs" })
}

resource "aws_efs_backup_policy" "this" {
  count          = var.is_backup_enabled ? 1 : 0
  file_system_id = aws_efs_file_system.this.id

  backup_policy {
    status = "ENABLED"
  }
}

resource "aws_efs_mount_target" "this" {
  for_each        = {for i, v in var.subnet_ids : i => v}
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = each.value
  security_groups = var.security_groups
}
