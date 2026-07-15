variable "tags" {
  description = "Additional tags applied to the GitHub OIDC provider."
  type        = map(string)
  default     = {}
}