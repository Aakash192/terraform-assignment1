variable "name" {
  type = string
  description = "Aakash Suryavanshi"
}

variable "subnet_ids" {
  type = list(string)
  description = "List of subnet IDs for VM network interfaces"
}
