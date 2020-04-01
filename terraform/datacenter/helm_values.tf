data "template_file" "values" {
  template = "${file("${path.module}/templates/values.tpl")}"
  vars = {
    datacenter_name = var.datacenter
    tag = "Env"
    value = local.cluster_name
  }
}

resource "local_file" "values" {
    content     = data.template_file.values.rendered
    filename = "../${local.cluster_name}_values.yaml"
}