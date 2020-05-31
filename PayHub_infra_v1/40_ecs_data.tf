
# ============================================ TEMPLATES  =====================================================

data "template_file" "windows-config-template" {
  template = "${file("${path.module}/user-data/iis-config.ps1")}"

  vars = {
    INSTANCE_USERNAME = var.temp_windows_user_name
    INSTANCE_PASSWORD = var.temp_windows_user_pass
  }
}

data "template_file" "win16-config-template" {
  template = "${file("${path.module}/user-data/win16-config.ps1")}"

  vars = {
    INSTANCE_USERNAME = var.temp_windows_user_name
    INSTANCE_PASSWORD = var.temp_windows_user_pass
  }
}

data "template_file" "jumpbox-config-template" {
  template = "${file("${path.module}/user-data/win16-config.ps1")}"

  vars = {
    INSTANCE_USERNAME = var.temp_windows_user_name
    INSTANCE_PASSWORD = var.temp_windows_user_pass
  }
}
