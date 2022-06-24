resource "aws_efs_file_system" "this" {
  tags = merge(var.tags, { Name = var.name })
}

resource "aws_efs_backup_policy" "this" {
  count          = var.enable_backup ? 1 : 0
  file_system_id = aws_efs_file_system.this.id

  backup_policy {
    status = "ENABLED"
  }
}

resource "aws_efs_mount_target" "this" {
  for_each        = { for i, v in var.subnets : i => v }
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = each.value
  security_groups = var.security_groups
}

resource "aws_efs_access_point" "this" {
  for_each = {
    for i, v in var.access_point :
    i => v
  }

  file_system_id = aws_efs_file_system.this.id

  dynamic "posix_user" {
    for_each = try(each.value.posix_user, null) != null ? ["true"] : []

    content {
      gid = each.value.posix_user.gid
      uid = each.value.posix_user.uid
    }
  }

  root_directory {
    path = each.value.root_directory

    dynamic "creation_info" {
      for_each = try(each.value.creation_info, null) != null ? ["true"] : []

      content {
        owner_gid   = each.value.creation_info.owner_gid
        owner_uid   = each.value.creation_info.owner_uid
        permissions = each.value.creation_info.permissions
      }
    }
  }

  tags = var.tags
}
