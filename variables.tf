variable "secrets" {
  type = map(object({
    description = string
    value       = string
  }))
}