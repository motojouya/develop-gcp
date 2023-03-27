# os loginはdefaultでtrueっぽい
# 本来はinstanceのmetadataに指定する
resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  tags = var.tags

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  service_account {
    email  = google_service_account.developer.email
    scopes = ["cloud-platform"]
  }




  metadata_startup_script = <<EOF
#!/bin/bash
curl https://raw.githubusercontent.com/motojouya/gce-develop/master/init.sh | bash -s -- ${var.instance_user} ${var.ssh_port}
EOF

  scheduling {
    preemptible         = true
    on_host_maintenance = "TERMINATE"
    automatic_restart   = false
  }
}
