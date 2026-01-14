# UAD Terraform Demo Module

This module is a very basic mockup of how terraform modules would be implemented in UAD.

In a real scenario the platform team would provide modules which guarantee compliance with security and cost rules within the company. For the purpose of this scenario I'm just using terraform as a proof of concept to run docker locally. 

The expectation would be that these modules are treated as assets themselves - immutable versions with testing logic, deployment logic, governance, and knowledge included as part of the asset. The final module is then retrievable from some artifact store and can be easily implemented in an application by developers by following the instructions laid out in the Asset.

For example, if this main.tf module were shipped as local-container-web-service-v1.0.0.tf, the README may look as below

---

### Overview
This Terraform module provides a standardized, governed, and secure way to deploy web services to our local production simulation environment (Docker).

It is designed to be the "Golden Path" for all internal web services, ensuring that every application we deploy meets our baseline requirements for security, resource management, and observability without developers needing to manage low-level Docker configuration.

### Usage

Add the following configuration to your project's infra/main.tf file.

#### Basic Configuration

```hcl
module "web_service" {
  # The location of the module after download relative to your main.tf file
  source = "../../_supply_chain/infrastructure/modules/local-web-service/v1.0"
  
  # The name of the application, this will be the name of the docker container.
  app_name = "my-service-name"
  
  # Networking
  # The port your application listens on internally (usually 3000 or 8080)
  # The module maps this to localhost:3000 automatically.
  host_port = 3000

  # Artifact Reference
  # This variable is automatically injected by the CI/CD pipeline.
  # Do not hardcode SHAs here.
  image_sha = var.image_digest
}
```