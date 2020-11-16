data "aws_ami" "fcos" {
  most_recent = true

  filter {
    name   = "name"
    values = ["fedora-coreos-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "description"
    values = ["Fedora CoreOS stable*"]
  }

  owners = ["125523088429"] # Fedora Project
}

data "template_file" "fcct" {
  template = file("${path.module}/fcct.yaml")
  vars = {
    base64_conf = base64encode(var.conf)
  }
}

data "ct_config" "fcct" {
  content      = data.template_file.fcct.rendered
  strict       = true
  pretty_print = false
}

resource "aws_instance" "mailcow" {
  ami           = data.aws_ami.fcos.id
  instance_type = "t3a.small"
  key_name      = var.key_name
  user_data     = data.ct_config.fcct.rendered

  ebs_block_device {
    # Strangly, this device name doesnt map to the actual
    # device name. It will be /dev/nvme1n1
    device_name = "/dev/sdb"
    volume_type = "gp2"
    volume_size = 30
  }
}
