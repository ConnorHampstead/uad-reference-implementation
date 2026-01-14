# Boilerplate to let terraform actually initialise. 

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {}

# Layer 2: Execution Context
# This instantiates the immutable "Local Web Service" module from the Supply Chain.

module "web_service" {
  source = "../_supply_chain/infrastructure/local-container-web-service/v1.0"

  # Required
  app_name = "uad-demo-app"
  host_port = 3000

  # Required, set dynamically by pipeline
  image_sha = var.image_digest
}