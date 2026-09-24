variable "project_id" {
  description = "Твоят GCP Project ID (от новия акаунт, не името на проекта)"
  type        = string
}

variable "project_name" {
  description = "Кратко име, използвано за именуване на ресурси"
  type        = string
  default     = "devops-portfolio"
}

variable "region" {
  description = "GCP регион"
  type        = string
  default     = "europe-west3" # Frankfurt - най-близо до България
}

variable "zone" {
  description = "GCP зона (регион + буква)"
  type        = string
  default     = "europe-west3-a"
}

variable "node_count" {
  description = "Брой nodes в node pool-а"
  type        = number
  default     = 2
}

variable "machine_type" {
  description = "Тип машина за nodes - e2-medium е евтин и достатъчен за демо"
  type        = string
  default     = "e2-medium"
}
