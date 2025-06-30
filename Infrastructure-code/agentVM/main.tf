data "azurerm_resource_group" "agentvm-rg" {
  name = "agentvm-RG"
}
output "resource_group_name_id" {
   value = data.azurerm_resource_group.agentvm-rg.id
}
  
data "azurerm_virtual_machine" "agentvm" {
    name = "AzureAgentVM"
    resource_group_name = data.azurerm_resource_group.agentvm-rg.name
  
}

resource "null_resource" "install_tools" {
  provisioner "remote-exec" {
    inline = ["${file("../agentVM/install.sh")}"]
    //inline = ["${file("../script.sh")}"]
    //inline = [file("${path.module}/path/to/inline_script.sh")]
    connection {
      type     = "ssh"
      user     = "azureuser"
      password = var.ssh_privatekey
      host     = data.azurerm_virtual_machine.agentvm.public_ip_address
      timeout  = "10m"
    }
  }

}
