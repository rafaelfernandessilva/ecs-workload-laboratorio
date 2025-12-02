resource "aws_launch_template" "spots" {
  count         = var.enable_spot ? 1 : 0
  name_prefix   = "${var.project_name}-on-spots"
  image_id      = var.ami != "" ? var.ami : data.aws_ami.this.id
  instance_type = var.instance_type
  vpc_security_group_ids = [
    aws_security_group.main.id
  ]

  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = var.price_spot
    }
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.this.name
  }

  update_default_version = true

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = var.volume_size
      volume_type = var.volume_type
    }
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-on-spots"
    }
  }
  user_data = base64encode(templatefile("${path.module}/templates/user_data.tpl", {
    ECS_CLUSTER = var.project_name
  }))

  depends_on = [
    aws_iam_role.this
  ]
}

