resource "aws_ecr_repository" "ecr_repo" {
  name                 = "${var.project_name}"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
force_delete = true

  tags = {
    Name        = "${var.project_name}-repo"
    Environment = "production"
  }
}
