variable "content" {
  default = "Hello world"
  type = string
  description = "ensure that the content is added"
}

variable "byte_length" {
  default = 8
  type = number
  description = "the length of the random var generated"
}

variable "file_permisson" {
  default = "0700"
  type = string
  description = "permissions associated with the file"
}
