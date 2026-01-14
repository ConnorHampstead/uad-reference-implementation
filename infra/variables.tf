variable "image_digest" {
  description = "The precise SHA256 digest of the Docker image to deploy. Injected by CI/CD."
  type        = string
}