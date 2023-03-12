# https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file.html
resource "local_file" "foo" {
  filename = "${path.module}/foo.txt"
  content = var.content
  file_permission = var.file_permission
}
resource "random_id" "server" {
  byte_length = var.byte_length
}
