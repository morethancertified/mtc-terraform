resource "docker_container" "nodered_container" {
  name  = var.name_in
  image = var.image_in
  ports {
    internal = var.int_port_in
    external = var.ext_port_in
  }
  volumes {
    container_path = "/data"
    volume_name    = docker_volume.container_volume.name
  }
}

resource "docker_volume" "container_volume" {
  name = "${var.name_in}-volume"
}


