terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

variable "app_name" { type = string }
variable "image_sha" { type = string }
variable "host_port" { type = number }

resource "docker_image" "app" {
  name         = var.image_sha
  keep_locally = true
}

resource "docker_container" "app" {
  image = docker_image.app.image_id
  name  = var.app_name
  
  ports {
    internal = 3000
    external = var.host_port
  }

  memory  = 512
  
  healthcheck {
    # Check if the app responds to a local request inside the container
    test         = ["CMD", "curl", "-f", "http://localhost:3000/"]
    interval     = "5s"    # How often to check
    timeout      = "2s"    # How long to wait for a response
    retries      = 5       # Try 5 times before failing
    start_period = "10s"   # Give the app 10s to boot before first check
  }
}