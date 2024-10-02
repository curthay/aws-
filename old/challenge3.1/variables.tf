variable "ingressrules" {
  type    = list(number)
  default = [80, 443, 3306]
}

variable "egressrules" {
  type    = list(number)
  default = [80, 443]
}