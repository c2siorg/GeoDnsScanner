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

# #########################################################################################################################################
#                                                     General Configurations - Playbook V1 (Depricated)
# #########################################################################################################################################

# NOTE:  Path Must be Relative to the main.tf Where Playbook is called as the local-exec by the Terraform

# 1. --> 
# playbook = "./playbooks/playbook_01_malicious_seed.yaml"

# 2. --> 
# playbook = "./playbooks/playbook_02_alexa_top.yaml"

# 3. --> 
# playbook = "./playbooks/playbook_03_alexa_low.yaml"
        
# 4. --> 
# playbook = "./playbooks/playbook_04_zone_files_random_1M.yaml"


# #########################################################################################################################################
#                                                     General Configurations - Playbook V2 (In Use)
# #########################################################################################################################################

# Playbook - DO NOT CHANGE
playbook = "./playbooks/playbook_v2.yaml"

# **** Configs for Each Playbook Experiment ****
# 1. -->
# ZDNS_script_local = "../scripts/run_zdns_A.sh"
# seed_file = "seed_alexa_top.txt"
# cloud_storage_bucket_results_dir = "results_alexa_top_A_ex03_10"
# cloud_storage_bucket_logs_dir = "logs_alexa_top_A_ex03_10"
# 2. -->
# ZDNS_script_local = "../scripts/run_zdns_CNAME.sh"
# seed_file = "seed_alexa_top.txt"
# cloud_storage_bucket_results_dir = "results_alexa_top_CNAME_ex03_10"
# cloud_storage_bucket_logs_dir = "logs_alexa_top_CNAME_ex03_10"
# 3. -->
# ZDNS_script_local = "../scripts/run_zdns_NS.sh"
# seed_file = "seed_alexa_top.txt"
# cloud_storage_bucket_results_dir = "results_alexa_top_NS_ex03_10"
# cloud_storage_bucket_logs_dir = "logs_alexa_top_NS_ex03_10"
# # 4. -->
# ZDNS_script_local = "../scripts/run_zdns_MX.sh"
# seed_file = "seed_alexa_top.txt"
# cloud_storage_bucket_results_dir = "results_alexa_top_MX_ex03_10"
# cloud_storage_bucket_logs_dir = "logs_alexa_top_MX_ex03_10"

# Lean on Me - Replication -->
# ZDNS_script_local = "../scripts/run_zdns_A.sh"
# seed_file = "seed_lean_on_me.txt"
# cloud_storage_bucket_results_dir = "results_lean_on_me_A"
# cloud_storage_bucket_logs_dir = "logs_lean_on_me_A"

# ZDNS_script_local = "../scripts/run_zdns_CNAME.sh"
# seed_file = "seed_lean_on_me.txt"
# cloud_storage_bucket_results_dir = "results_lean_on_me_CNAME"
# cloud_storage_bucket_logs_dir = "logs_lean_on_me_CNAME"

# ZDNS_script_local = "../scripts/run_zdns_MX.sh"
# seed_file = "seed_lean_on_me.txt"
# cloud_storage_bucket_results_dir = "results_lean_on_me_MX"
# cloud_storage_bucket_logs_dir = "logs_lean_on_me_MX"

# ZDNS_script_local = "../scripts/run_zdns_NS.sh"
# seed_file = "seed_lean_on_me.txt"
# cloud_storage_bucket_results_dir = "results_lean_on_me_NS"
# cloud_storage_bucket_logs_dir = "logs_lean_on_me_NS"

# ZDNS_script_local = "../scripts/run_zdns_PTR.sh"
# seed_file = "seed_ip.txt"
# cloud_storage_bucket_results_dir = "results_lean_on_me_PTR"
# cloud_storage_bucket_logs_dir = "logs_lean_on_me_PTR"


# 5. -->
# ZDNS_script_local = "../scripts/run_zdns_A.sh"
# seed_file = "seed_alexa_low.txt"
# cloud_storage_bucket_results_dir = "results_alexa_low_A_ex03_04"
# cloud_storage_bucket_logs_dir = "logs_alexa_low_A_ex03_04"
# # 6. -->
# ZDNS_script_local = "../scripts/run_zdns_CNAME.sh"
# seed_file = "seed_alexa_low.txt"
# cloud_storage_bucket_results_dir = "results_alexa_low_CNAME_ex03_04"
# cloud_storage_bucket_logs_dir = "logs_alexa_low_CNAME_ex03_04"
# # 7. -->
ZDNS_script_local = "../scripts/run_zdns_MX.sh"
seed_file = "seed_alexa_low.txt"
cloud_storage_bucket_results_dir = "results_alexa_low_MX_ex03_01"
cloud_storage_bucket_logs_dir = "logs_alexa_low_MX_ex03_01"
# # 8. -->
# ZDNS_script_local = "../scripts/run_zdns_MX.sh"
# seed_file = "seed_alexa_low.txt"
# cloud_storage_bucket_results_dir = "results_alexa_low_MX_ex03_04"
# cloud_storage_bucket_logs_dir = "logs_alexa_low_MX_ex03_04"

/*
# 9. -->
ZDNS_script_local = "../scripts/run_zdns_A.sh"
seed_file = "seed_alexa_top.txt"
cloud_storage_bucket_results_dir = "results_alexa_top_A_ex03_01"
cloud_storage_bucket_logs_dir = "logs_alexa_top_A_ex03_01"
# 10. -->
ZDNS_script_local = "../scripts/run_zdns_CNAME.sh"
seed_file = "seed_alexa_top.txt"
cloud_storage_bucket_results_dir = "results_alexa_top_CNAME_ex03_01"
cloud_storage_bucket_logs_dir = "logs_alexa_top_CNAME_ex03_01"
# 11. -->
ZDNS_script_local = "../scripts/run_zdns_NS.sh"
seed_file = "seed_alexa_top.txt"
cloud_storage_bucket_results_dir = "results_alexa_top_NS_ex03_01"
cloud_storage_bucket_logs_dir = "logs_alexa_top_NS_ex03_01"
# 12. -->
ZDNS_script_local = "../scripts/run_zdns_MX.sh"
seed_file = "seed_alexa_top.txt"
cloud_storage_bucket_results_dir = "results_alexa_top_MX_ex03_01"
cloud_storage_bucket_logs_dir = "logs_alexa_top_MX_ex03_01"


# 13. -->
ZDNS_script_local = "../scripts/run_zdns_A.sh"
seed_file = "seed_alexa_top.txt"
cloud_storage_bucket_results_dir = "results_alexa_top_A_ex03_01"
cloud_storage_bucket_logs_dir = "logs_alexa_top_A_ex03_01"
# 14. -->
ZDNS_script_local = "../scripts/run_zdns_CNAME.sh"
seed_file = "seed_alexa_top.txt"
cloud_storage_bucket_results_dir = "results_alexa_top_CNAME_ex03_01"
cloud_storage_bucket_logs_dir = "logs_alexa_top_CNAME_ex03_01"
# 15. -->
ZDNS_script_local = "../scripts/run_zdns_NS.sh"
seed_file = "seed_alexa_top.txt"
cloud_storage_bucket_results_dir = "results_alexa_top_NS_ex03_01"
cloud_storage_bucket_logs_dir = "logs_alexa_top_NS_ex03_01"
# 16. -->
ZDNS_script_local = "../scripts/run_zdns_MX.sh"
seed_file = "seed_alexa_top.txt"
cloud_storage_bucket_results_dir = "results_alexa_top_MX_ex03_01"
cloud_storage_bucket_logs_dir = "logs_alexa_top_MX_ex03_01"
*/
# **** End Config for Each Play Book Experiment ****
# #########################################################################################################################################

# SSH Info
ssh_user = "ssh_user"
ssh_password = ""
ssh_key_public = "/home/pasindud/.ssh/ssh_key.pub"
ssh_key_private = "/home/pasindud/.ssh/ssh_key"

# #########################################################################################################################################
#                                       VM Location - Project / Region / Zone / Instance Unique Name
# #########################################################################################################################################
vm_nodes = {
    node_01: {project_id: "fluid-mix-301105", region: "us-central1", zone: "us-central1-c", vm_name:"terra-ansi-instance-01"}
    node_02: {project_id: "fluid-mix-301105", region: "us-east1", zone: "us-east1-b", vm_name:"terra-ansi-instance-02"}
    node_03: {project_id: "fluid-mix-301105", region: "us-west3", zone: "us-west3-a", vm_name:"terra-ansi-instance-03"}
    node_04: {project_id: "fluid-mix-301105", region: "europe-west2", zone: "europe-west2-a", vm_name:"terra-ansi-instance-04"}

    node_05: {project_id: "adns-project-03", region: "europe-west4", zone: "europe-west4-a", vm_name:"terra-ansi-instance-05"}
    node_06: {project_id: "adns-project-03", region: "europe-north1", zone: "europe-north1-a", vm_name:"terra-ansi-instance-06"}
    node_07: {project_id: "adns-project-03", region: "europe-west6", zone: "europe-west6-a", vm_name:"terra-ansi-instance-07"}
    node_08: {project_id: "adns-project-03", region: "asia-east2", zone: "asia-east2-a", vm_name:"terra-ansi-instance-08"}

    node_09: {project_id: "adns-project-04", region: "asia-northeast1", zone: "asia-northeast1-a", vm_name:"terra-ansi-instance-09"}
    node_10: {project_id: "adns-project-04", region: "asia-northeast3", zone: "asia-northeast3-a", vm_name:"terra-ansi-instance-10"}
    node_11: {project_id: "adns-project-04", region: "asia-southeast1", zone: "asia-southeast1-a", vm_name:"terra-ansi-instance-11"}
    node_12: {project_id: "adns-project-04", region: "australia-southeast1", zone: "australia-southeast1-a", vm_name:"terra-ansi-instance-12"}
    
    node_13: {project_id: "fluid-mix-301105", region: "southamerica-east1", zone: "southamerica-east1-a", vm_name:"terra-ansi-instance-13"}
    node_14: {project_id: "adns-project-01-303514", region: "northamerica-northeast1", zone: "northamerica-northeast1-a", vm_name:"terra-ansi-instance-14"}

    # NOT USED
    # node_15: {project_id: "adns-project-01-303514", region: "us-central1", zone: "us-central1-c", vm_name:"terra-ansi-instance-15"}
    # node_16: {project_id: "adns-project-01-303514", region: "us-central1", zone: "us-central1-c", vm_name:"terra-ansi-instance-16"}

    # node_17: {project_id: "adns-project-02-304511", region: "us-central1", zone: "us-central1-c", vm_name:"terra-ansi-instance-17"}
    # node_18: {project_id: "adns-project-02-304511", region: "us-central1", zone: "us-central1-c", vm_name:"terra-ansi-instance-18"}
    # node_19: {project_id: "adns-project-02-304511", region: "us-central1", zone: "us-central1-c", vm_name:"terra-ansi-instance-19"}
    # node_20: {project_id: "adns-project-02-304511", region: "us-central1", zone: "us-central1-c", vm_name:"terra-ansi-instance-20"}

    # node_21: {project_id: "rugged-diagram-300800", region: "us-central1", zone: "us-central1-c", vm_name:"terra-ansi-instance-21"}
    # node_22: {project_id: "rugged-diagram-300800", region: "us-central1", zone: "us-central1-c", vm_name:"terra-ansi-instance-22"}
    # node_23: {project_id: "rugged-diagram-300800", region: "us-central1", zone: "us-central1-c", vm_name:"terra-ansi-instance-23"}
    # node_24: {project_id: "rugged-diagram-300800", region: "us-central1", zone: "us-central1-c", vm_name:"terra-ansi-instance-24"}

}

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