provider "yandex" {
  #service_account_key_file = var.service_account_key_file
  token     = "AgAAAAALPkoYAATuwTRqjuwUsEIIibJSCN!bQmw"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

resource "yandex_compute_instance" "node" {
  name = "node-1"

  resources {
    cores  = 4
    memory = 4
  }
  
boot_disk {
    initialize_params {
      # ������� id ������ ���������� � ���������� ������� �������
      image_id = var.image_id
      size = 40
    }
  }

  network_interface {
    # ������ id ������� default-ru-central1-a
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = yandex_compute_instance.app.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # ���� �� ���������� �����
    private_key = file(var.path_private_key)
  }

}