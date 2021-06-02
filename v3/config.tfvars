# #########################################################################################################################################
#                                                         Projects
# #########################################################################################################################################
projects = {
    # DNSIP03
    ADNS_Project_01: "fluid-mix-301105"               # Max 4
    ADNS_Project_02: "adns-project-03"                # Max 4
    ADNS_Project_03: "adns-project-04"                # Max 4
    # DNSIP04
    ADNS_Project_04: "adns-project-01-303514"         # Max 4
    ADNS_Project_05: "adns-project-02-304511"         # Max 4
    ADNS_Project_06: "rugged-diagram-300800"          # Max 3

}


# SSH Info
ssh_user = "ssh_user"
ssh_password = ""
ssh_key_public = "/home/pasindud/.ssh/ssh_key.pub"
ssh_key_private = "/home/pasindud/.ssh/ssh_key"


# #########################################################################################################################################
#                                       VM Specification - Configurations
# #########################################################################################################################################
vm_types = {

    minimal: {
        boot_disk_image: "debian-cloud/debian-10",
        # In VM Local Storage - GB
        boot_disk_size: 50,

        boot_disk_type: "pd-standard"

        network_interface_network: "default",

        machine_type: "e2-micro"

    }
}