terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

# #########################################################################################################################################
#                                                            Resources
# #########################################################################################################################################
resource "google_compute_instance" "vm_instance" {
    for_each = var.vm_nodes

    # Project
    project = each.value.project_id
    # VM Instance Name
    name = each.value.vm_name

    # Machine Type
    machine_type = var.vm_types["minimal"].machine_type

    # The zone that the machine should be created in. If it is not provided, the provider zone is used.
    zone = each.value.zone

    # desired_status = "RUNNING"

    # Boot Disk and OS
    boot_disk {
        initialize_params {
            image = var.vm_types["minimal"].boot_disk_image
            size = var.vm_types["minimal"].boot_disk_size
            type = var.vm_types["minimal"].boot_disk_type
        }
    }

    # Network Settings
    network_interface {
        # A default network is created for all GCP projects 
        network = var.vm_types["minimal"].network_interface_network
        access_config {
            # Include this section to give the VM an external ip address
        }
    }

    # Optional Start Script 
    # metadata_startup_script = file("./setup.sh")

    # Service Account to be Used
    #   service_account {
    #     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    #     email  = "test-service-acc@adns-project-01-303514.iam.gserviceaccount.com"
    #     scopes = ["cloud-platform"]
    # }

  tags = ["http-server","https-server", "externalssh"]

  # Ensure firewall rule is provisioned before server, so that SSH doesn't fail.
  # depends_on = ["google_compute_firewall.firewall-externalssh-${each.value.vm_name}"]


  # Enable SSH By Setting the SSH Public Key File Path
  metadata = {
    ssh-keys = "ssh_user:${file(var.ssh_key_public)}"
  }
  
  # Note: Provisioners should only be used as a last resort. For most common situations there are better alternatives.

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt -y install python-pip"]

    connection {
      # The connection type that should be used. Valid types are ssh and winrm. Defaults to ssh
      type     = "ssh"

      # The port to connect to. Defaults to 22 when using type ssh and defaults to 5985 when using type winrm.
      port = 22

      # The user that we should use for the connection. Defaults to root when using type ssh and defaults to Administrator when using type winrm.
      user     = var.ssh_user
      
      # The password we should use for the connection. In some cases this is specified by the provider. 
      password = var.ssh_password

      # (Required) The address of the resource to connect to.
      host = self.network_interface[0].access_config[0].nat_ip
      # Note: The self object represents the connection's parent resource, and has all of that resource's attributes. For example, use self.public_ip to reference an gcp_instance's public_ip attribute.

      # The contents of an SSH key to use for the connection. These can be loaded from a file on disk using the file function. This takes preference over the password if provided.
      private_key = "${file(var.ssh_key_private)}"

      # The timeout to wait for the connection to become available. Should be provided as a string like 30s or 5m. Defaults to 5 minutes.
      timeout = "5m"


    }
  }

  # Note: This Directory Must Include
  #  1. GCP SSH Private Key File
  #  2. Ansible Playbook
  #  3. GCP Service Account Key JSON File
  #  4. Other Bash Script Files Required 
  provisioner "local-exec" {
    command = "ansible-playbook --extra-vars='{\"region\": ${each.value.region}, \"zone\": ${each.value.zone}, \"vm_name\": ${each.value.vm_name}, \"seed_file\": ${var.seed_file}, \"ZDNS_script_local\": ${var.ZDNS_script_local}, \"cloud_storage_bucket_results_dir\": ${var.cloud_storage_bucket_results_dir}, \"cloud_storage_bucket_logs_dir\": ${var.cloud_storage_bucket_logs_dir} }' -i '${self.network_interface[0].access_config[0].nat_ip},' ${var.playbook}"
  }

}


# #########################################################################################################################################
#                                                          Firewall Rules
# #########################################################################################################################################
# resource "google_compute_firewall" "firewall-externalssh" {
#   for_each = var.vm_nodes

#   project = each.value.project_id
#   name    = "firewall-externalssh-${each.value.vm_name}"
#   network = "default"

#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }

#   source_ranges = ["0.0.0.0/0"]
#   target_tags   = ["externalssh"]
# }


# #########################################################################################################################################
#                                                            Output
# ######################################################################################################################################### 
# output "ip" {
#     value = google_compute_instance.vm_instance_04[0].network_interface.0.access_config.0.nat_ip   
#   }