variable "vpc_id" {
  type = string
}

variable "ingressrules" {
  type = list(number)
}

variable "egressrules" {
  type = list(number)
}