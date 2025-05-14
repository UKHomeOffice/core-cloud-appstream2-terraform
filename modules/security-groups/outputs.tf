output "appstream_security_group_id" {
  description = "ID of the AppStream security group"
  value = aws_security_group.appstream_security_group.id
}

