variable "resource_group_name" {
  type = string
}


variable "location" {
  type    = string
  default = "westeurope"

  
}
variable "environment" {
  type = string
  

}

variable "project_prefix" {
  type = string

  

}
variable "data_conteiners" {
    type = list(object({
        name = string
        access_type = string
}))
  
}

variable "data" {
    type = map(object({
        name = string
        content = string
        file_extension = string
    }))
}