variable "name" {
  type = string
  description = "Aakash Suryavanshi"
}

variable "allowed_ports" {
  type = list(number)
  description = "List of allowed ports (default: 22, 3389, 5985, 80)"
  default = [22, 3389, 5985, 80]
}
