variable "location" {}

variable "username" {}

variable "prefix" {
    type = "string"
    default = "calculator"
}

variable "tags" {
    type = "map"

    default = {
        Environment = "Calculator. Rails Example"
        Dept = "Engineering"
  }
}

variable "sku" {
    default = {
        centralus = "18.04-LTS"
    }
}