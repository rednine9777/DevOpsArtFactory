variable "example_map" {
  type = map(string)
  default = {
    key1 = "value1"
    key2 = "value2"
    key3 = "value3"
  }
}

locals {
  map_to_tuple = tolist([for k, v in var.example_map : { key = k, value = v }])
}

output "map_to_tuple_output" {
  value = local.map_to_tuple
}

