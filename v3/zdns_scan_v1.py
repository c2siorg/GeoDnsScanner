import subprocess
from datetime import datetime
from google.cloud import storage
from google.oauth2 import service_account
# import animation
import time
import os
import json
import googleapiclient.discovery

# Google Cloud Storage
credentials = service_account.Credentials.from_service_account_file("./keys/service_account.json")
client = storage.Client(credentials=credentials)
# bucket = client.get_bucket('ansible_test_01')
# blobs = bucket.list_blobs()

DIR_EXEC = "/home/pasindud/v2"
SERVICE_ACCOUNT = "./keys/service_account.json"

VM_NODES = [
        {"node_key": "node_01" , "project_id": "fluid-mix-301105", "region": "us-central1", "zone": "us-central1-c", "vm_name":"terra-ansi-instance-01"}, 
        {"node_key": "node_02" , "project_id": "fluid-mix-301105", "region": "us-east1", "zone": "us-east1-b", "vm_name":"terra-ansi-instance-02"},
        {"node_key": "node_03" , "project_id": "fluid-mix-301105", "region": "us-west3", "zone": "us-west3-a", "vm_name":"terra-ansi-instance-03"},
        {"node_key": "node_04" , "project_id": "fluid-mix-301105", "region": "europe-west2", "zone": "europe-west2-a", "vm_name":"terra-ansi-instance-04"},
        {"node_key": "node_05" , "project_id": "adns-project-03", "region": "europe-west4", "zone": "europe-west4-a", "vm_name":"terra-ansi-instance-05"},
        {"node_key": "node_06" , "project_id": "adns-project-03", "region": "europe-north1", "zone": "europe-north1-a", "vm_name":"terra-ansi-instance-06"},
        {"node_key": "node_07" , "project_id": "adns-project-03", "region": "europe-west6", "zone": "europe-west6-a", "vm_name":"terra-ansi-instance-07"},
        {"node_key": "node_08" , "project_id": "adns-project-03", "region": "asia-east2", "zone": "asia-east2-a", "vm_name":"terra-ansi-instance-08"},
        {"node_key": "node_09" , "project_id": "adns-project-04", "region": "asia-northeast1", "zone": "asia-northeast1-a", "vm_name":"terra-ansi-instance-09"},
        {"node_key": "node_10" , "project_id": "adns-project-04", "region": "asia-northeast3", "zone": "asia-northeast3-a", "vm_name":"terra-ansi-instance-10"},
        {"node_key": "node_11" , "project_id": "adns-project-04", "region": "asia-southeast1", "zone": "asia-southeast1-a", "vm_name":"terra-ansi-instance-11"},
        {"node_key": "node_12" , "project_id": "adns-project-04", "region": "australia-southeast1", "zone": "australia-southeast1-a", "vm_name":"terra-ansi-instance-12"},
        {"node_key": "node_13" , "project_id": "fluent-spring-308006", "region": "southamerica-east1", "zone": "southamerica-east1-a", "vm_name":"terra-ansi-instance-13"},
        {"node_key": "node_14" , "project_id": "fluent-spring-308006", "region": "northamerica-northeast1", "zone": "northamerica-northeast1-a", "vm_name":"terra-ansi-instance-14"}
    ]


# #############################################################################################
#                               Get All Failed Nodes After a Scan has Done
# #############################################################################################
def get_failed_nodes(dir_name, no_of_files=14):

    # NOTE: Node Indexing SHould Start From 1

    # Google Cloud Storage
    credentials = service_account.Credentials.from_service_account_file(SERVICE_ACCOUNT)
    client = storage.Client(credentials=credentials)
    # bucket = client.get_bucket('ansible_test_01')
    # blobs = bucket.list_blobs()
    
    if dir_name == "": return None

    file_indices = []
    failed_nodes = []

    for blob in client.list_blobs('ansible_test_01', prefix = dir_name):
        # print(str(blob.name).split("/")[1])
        file_indices.append(int(str(blob.name.split(".")[0].split("-")[-1])))

    
    for index in range(1, no_of_files + 1):
        if index not in file_indices:
            failed_nodes.append(index)

    return failed_nodes

# #############################################################################################
#                                      Cosole Logging with Time Stamp
# #############################################################################################
def console_log(message):
    print("" + datetime.now().strftime("%d/%m/%Y %H:%M:%S") + " | " + message)


# #############################################################################################
#                               Make Apply Command String - Dynamically
# #############################################################################################
def make_apply_command(playbook, config_file, ZDNS_script_file, cloud_storage_bucket_results_dir, cloud_storage_bucket_logs_dir, seed_file,  vm_nodes_all, vm_nodes_active):
    # NOTE: Replace Spaces Between Commands With $ Character
    cmd_apply_main = "terraform$apply"
    cmd_apply_var_playbook = "$-var$playbook=" + playbook
    # cmd_apply_var_vm_nodes = "$-var$'vm_nodes={ \"node_01\": {\"project_id\": \"fluid-mix-301105\", \"region\": \"us-central1\", \"zone\": \"us-central1-c\", vm_name:\"terra-ansi-instance-01\"}, \"node_02\": {\"project_id\": \"fluid-mix-301105\", \"region\": \"us-east1\", \"zone\": \"us-east1-b\", vm_name:\"terra-ansi-instance-02\"},\"node_03\": {\"project_id\": \"fluid-mix-301105\", \"region\": \"us-west3\", \"zone\": \"us-west3-a\", vm_name:\"terra-ansi-instance-03\"},\"node_04\": {\"project_id\": \"fluid-mix-301105\", \"region\": \"europe-west2\", \"zone\": \"europe-west2-a\", vm_name:\"terra-ansi-instance-04\"},\"node_05\": {\"project_id\": \"adns-project-03\", \"region\": \"europe-west4\", \"zone\": \"europe-west4-a\", vm_name:\"terra-ansi-instance-05\"},\"node_06\": {\"project_id\": \"adns-project-03\", \"region\": \"europe-north1\", \"zone\": \"europe-north1-a\", vm_name:\"terra-ansi-instance-06\"},\"node_07\": {\"project_id\": \"adns-project-03\", \"region\": \"europe-west6\", \"zone\": \"europe-west6-a\", vm_name:\"terra-ansi-instance-07\"},\"node_08\": {\"project_id\": \"adns-project-03\", \"region\": \"asia-east2\", \"zone\": \"asia-east2-a\", vm_name:\"terra-ansi-instance-08\"},\"node_09\": {\"project_id\": \"adns-project-04\", \"region\": \"asia-northeast1\", \"zone\": \"asia-northeast1-a\", vm_name:\"terra-ansi-instance-09\"},\"node_10\": {\"project_id\": \"adns-project-04\", \"region\": \"asia-northeast3\", \"zone\": \"asia-northeast3-a\", vm_name:\"terra-ansi-instance-10\"},\"node_11\": {\"project_id\": \"adns-project-04\", \"region\": \"asia-southeast1\", \"zone\": \"asia-southeast1-a\", vm_name:\"terra-ansi-instance-11\"},\"node_12\": {\"project_id\": \"adns-project-04\", \"region\": \"australia-southeast1\", \"zone\": \"australia-southeast1-a\", vm_name:\"terra-ansi-instance-12\"},\"node_13\": {\"project_id\": \"fluent-spring-308006\", \"region\": \"southamerica-east1\", \"zone\": \"southamerica-east1-a\", vm_name:\"terra-ansi-instance-13\"},\"node_14\": {\"project_id\": \"fluent-spring-308006\", \"region\": \"northamerica-northeast1\", \"zone\": \"northamerica-northeast1-a\", vm_name:\"terra-ansi-instance-14\"}}'"
    cmd_apply_var_vm_nodes = "$-var$vm_nodes={ "


    # Added Required VM Nodes to the String
    added_count = 0
    for index, node in enumerate(vm_nodes_all):
        if index + 1 in vm_nodes_active:
            added_count += 1
            cmd_apply_var_vm_nodes += f"\"{node['node_key']}\": {{\"project_id\": \"{node['project_id']}\", \"region\": \"{node['region']}\", \"zone\": \"{node['zone']}\", \"vm_name\": \"{node['vm_name']}\"}}"
            if len(vm_nodes_active) != added_count:
                cmd_apply_var_vm_nodes += ", " 
         
    cmd_apply_var_vm_nodes += " }"


    # cmd_apply_var_vm_nodes = "$-var$vm_nodes={ \"node_01\": {\"project_id\": \"fluid-mix-301105\", \"region\": \"us-central1\", \"zone\": \"us-central1-c\", vm_name:\"terra-ansi-instance-01\"}}"
    cmd_apply_vars_file_config = "$-var-file$" + config_file
    cmd_apply_var_ZDNS_script = "$-var$ZDNS_script_local=" + ZDNS_script_file
    cmd_apply_var_seed_file = "$-var$seed_file=" + seed_file
    cmd_apply_cloud_storage_bucket_results_dir = "$-var$cloud_storage_bucket_results_dir=" + cloud_storage_bucket_results_dir
    cmd_apply_var_cloud_storage_bucket_logs_dir = "$-var$cloud_storage_bucket_logs_dir=" + cloud_storage_bucket_logs_dir
    cmd_auto_approve_flag = "$-auto-approve"
    cmd_apply = cmd_apply_main + cmd_auto_approve_flag + cmd_apply_var_playbook + cmd_apply_var_vm_nodes + cmd_apply_var_ZDNS_script + cmd_apply_var_seed_file + cmd_apply_cloud_storage_bucket_results_dir + cmd_apply_var_cloud_storage_bucket_logs_dir + cmd_apply_vars_file_config

    # print(cmd_apply)
    return cmd_apply.split("$")


def make_destroy_command():
    cmd_destroy_main = "terraform$destroy"
    cmd_auto_approve_flag = "$-auto-approve"
    cmd_destroy = cmd_destroy_main + cmd_auto_approve_flag

    return cmd_destroy.split("$")

# #############################################################################################
#                      Run Apply Command and Handle the Reamining Work Flow
# #############################################################################################
def run_DNS_scan(vm_nodes_active, scan_suffix="", seed_file="", ZDNS_script="", vm_nodes_all, save_shell_logs=False):
    
    # While All Nodes - Done: 
    #   Make Command String
    #   Run Apply Command
    #   Destroy Infrastructure
    #   Validate Output
    #   Re-Run Failed Nodes

    cloud_storage_bucket_results_dir = "results_" + scan_suffix
    cloud_storage_bucket_logs_dir = "logs_" + scan_suffix
    playbook = "./playbooks/playbook_v2.yaml"
    config_file = "config.tfvars"
    ZDNS_script_file = "../scripts/" + ZDNS_script

    all_success = False
    current_active_nodes = vm_nodes_active
    attempt = 1

    console_log("DNS Scan Settings")

    console_log(" * DNS Scan Running On : " + str(len(current_active_nodes) )+ " VM Nodes")
    str_temp_nodes = ""
    for node in current_active_nodes:
        str_temp_nodes += f"Node {str(node)} | "
    console_log(" * VM Nodes to be Run  : " + str_temp_nodes)
    console_log(" * Seed File           : " + seed_file)
    console_log(" * ZDNS Script File    : " + ZDNS_script)
    console_log(" * Playbook            : " + playbook.split("/")[-1])

    console_log("")

    while not all_success:

        timestamp = datetime.now().strftime("%d%m%Y_%H%M%S")

        # Check for remaining VM Instance from Previous DNS Scan, If there is any DELETE ALL before this DNS Scan Begins
        clear_previous_vms(vm_nodes_all)

        console_log("Estimated Timeout: ")

        console_log("DNS Scan Attempt:  " + str(attempt))
        listed_cmd = make_apply_command(playbook, config_file, ZDNS_script_file, cloud_storage_bucket_results_dir, cloud_storage_bucket_logs_dir, seed_file, vm_nodes_all, current_active_nodes)
        console_log("DNS Scan Started...")
        console_log("Running...")
        cmd_log_apply = subprocess.run(listed_cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
        console_log("DNS Scan Finished")
        console_log("Validating Terraform Apply Execution...")
        if cmd_log_apply.returncode != 0:
            console_log("Something Went Wrong While Executing the Terraform Apply. !!!! PLEASE SEE THE LOGS !!!!")

            with open("terraform_apply_" + timestamp +"_.log", "w", encoding="utf-8") as file:
                file.write(str(cmd_log_apply.stdout).rstrip())
        else: 
            console_log("Terraform Apply Executed Successfully")

            if save_shell_logs:
                with open("terraform_apply_" + timestamp +"_.log", "w", encoding="utf-8") as file:
                    file.write(str(cmd_log_apply.stdout).rstrip())


        # **** Infrastructure Destruction *****
        # TODO: Add Re-try for Terrafor Destroy By Using While Loop If It Fails to Destroy All at Once
        listed_cmd = make_destroy_command()
        console_log("Infrastructure Destruction Started...")
        console_log("Running...")
        cmd_log_destroy = subprocess.run(listed_cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
        console_log("Infrastructure Destruction Finished")

        summary_msg = str(cmd_log_destroy.stdout).split("\n")[-2].strip()
        # LOOKIN FOR: "Destroy complete! Resources: 1 destroyed. "
        console_log("Validating Infrastructure Destruction...")
        if summary_msg.startswith("Destroy complete!") and cmd_log_destroy.returncode == 0:
            console_log("Terraform Destroy Executed Successfully")
            console_log("No of Nodes Destroyed: " + summary_msg.split(" ")[3])

            if save_shell_logs:
                with open("terraform_destroy_" + timestamp +"_.log", "w", encoding="utf-8") as file:
                    file.write(str(cmd_log_destroy.stdout).rstrip())
        else: 
            console_log("Something Went Wrong While Executing the Terraform Destroy. !!!! PLEASE SEE THE LOGS !!!!")

            with open("terraform_destroy_" + datetime.now().strftime("%d%m%Y_%H%M%S") +"_.log", "w", encoding="utf-8") as file:
                file.write(str(cmd_log_destroy.stdout).rstrip())
            

        # **** Final Validation ****
        console_log("Validating the Task Completion...")
        failed_nodes = get_failed_nodes(cloud_storage_bucket_logs_dir + "/", no_of_files=len(vm_nodes_active))
        summary_msg = str(cmd_log_apply.stdout).split("\n")[-2].strip()
        console_log("Validation Completed")

        # LOOKING FOR: "Apply complete! Resources: 1 added, 0 changed, 0 destroyed."
        if summary_msg.startswith("Apply complete!") and len(failed_nodes) == 0:
            console_log("Task Completed Successfully :)")
            all_success = True
        else:
            console_log("Task Not Completed, No of Failed Nodes Detected: " + str(len(failed_nodes)))
            str_temp_failed_nodes = ""
            for node in failed_nodes:
                str_temp_failed_nodes += f"Node {str(node)} | "
            console_log("Failed Nodes: " + str_temp_failed_nodes)

            current_active_nodes = failed_nodes
            all_success = False
            attempt += 1

            console_log("Re-Running Failed Nodes...")


# #############################################################################################
#                               Check For Existing VMs on Each Account
# #############################################################################################
def clear_previous_vms(all_vm_nodes):

    vm_names = []
    delete_vms = []
    project_ids = set()
    compute = googleapiclient.discovery.build('compute', 'v1')

    for node in all_vm_nodes:
        vm_names.append(node["vm_name"])
        project_ids.add(node["project_id"])

    console_log("Getting All VM Instances Across All Projects...")
    list_vm = list_instances(compute, project_ids)
    console_log(f"No of VMs Found: {str(len(list_vm))}")

    for vm in list_vm:
        if vm["name"] in vm_names:
            delete_vms.append(vm)

    if len(delete_vms) > 0:
        console_log(f"VM Nodes to be DELETED: {len(delete_vms)}")
        for vm in delete_vms:
            console_log(f'Deleting >> {vm["name"]} in {vm["zone"]} of Project: {vm["project_id"]}...')
            delete_instance(compute, vm["project_id"], vm["zone"], vm["name"])
            console_log("Deletion Completed")
    else:
        console_log("All Clear - Nothing to Delete")

def delete_instance(compute, project, zone, name):
    return compute.instances().delete(
        project=project,
        zone=zone,
        instance=name).execute()

def list_instances(compute, project_ids):
    list_vm = []

    for project_id in project_ids:
        keys_zones = []
        result = compute.instances().aggregatedList(project=project_id).execute()

        for zone in result["items"]:
            keys_zones.append(zone)

        for zone in keys_zones:
            if "instances" in result["items"][zone]:
                for instance in result["items"][zone]["instances"]:
                    list_vm.append({"name": instance["name"], "project_id": project_id, "zone": instance["zone"].split("/")[-1]})
            
    return list_vm

# #############################################################################################
#                               Terraform Version Check
# #############################################################################################
def terraform_version_check():
    version = "v0.14.5"

    cmd_version = "terraform$--version"
    listed_cmd = cmd_version.split("$")
    cmd_log_version = subprocess.run(listed_cmd, stdout=subprocess.PIPE, text=True)

    version_line = str(cmd_log_version.stdout).split("\n")[0].strip()
    if version_line.startswith("Terraform"):
        console_log("Terraform Installation Detected")

        if version_line.split(" ")[1].strip() == version:
            console_log("Terraform Version Requirement Statisfied: " + version)
        else:
            console_log("WARNING!!! Terafform Version Mismatched Detected. Required: " + version + " , Detected: " + version_line.split(" ")[1].strip())

        return True
    else:
        console_log("Terraform NOT Installed")
        return False



# #############################################################################################
#                               Ansible Version Check
# #############################################################################################
def anisble_version_check():
    version = "2.9.6"

    cmd_version = "ansible$--version"
    listed_cmd = cmd_version.split("$")
    cmd_log_version = subprocess.run(listed_cmd, stdout=subprocess.PIPE, text=True)

    version_line = str(cmd_log_version.stdout).split("\n")[0].strip()
    if version_line.startswith("ansible"):
        console_log("Ansible Installation Detected")

        if version_line.split(" ")[1].strip() == version:
            console_log("Ansible Version Requirement Statisfied: " + version)
        else:
            console_log("WARNING!!! Ansible Version Mismatch Detected. Required: " + version + " , Detected: " + version_line.split(" ")[1].strip())

        return True
    else:
        console_log("Ansible NOT Installed")
        return False


# #############################################################################################
#                               Set Environment Variables
# #############################################################################################
def set_environment_vars(service_account_file):
    console_log("Setting up the Environment Variables...")
 
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = str(service_account_file)
    os.environ["ANSIBLE_HOST_KEY_CHECKING"] = "False"

    console_log("Setting up the Environment Variables: Done")
    

# #############################################################################################
#                               Main Function
# #############################################################################################
def main():

    service_account_file = "/home/pasindud/v2/keys/service_account.json"
    DNS_scan_list_file = "./DNS_Scans.json" 
    interval_seconds = 60

    # NOTE: DO NOT ALTER CODE BELOW, UNLESS NEEDED
    terraform_version_check()
    anisble_version_check()
    set_environment_vars(service_account_file)


    # For All 14 Nodes
    # vm_nodes = [*range(1, len(VM_NODES) + 1)]
    
    DNS_scans = []
    with open(DNS_scan_list_file, "r", encoding="utf-8") as file:
        DNS_scans = json.load(file)

    console_log("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    for index, DNS_scan in enumerate(DNS_scans):

        console_log("**** DNS Scan - " + DNS_scan["name"] + " ****")
        run_DNS_scan(vm_nodes_active=DNS_scan["vm_nodes_active"], scan_suffix=DNS_scan["scan_suffix"], seed_file=DNS_scan["seed_file"], ZDNS_script=DNS_scan["ZDNS_script_file"], vm_nodes_all=VM_NODES,  save_shell_logs=True)
        console_log("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")

        if index != len(DNS_scans) - 1:
            console_log("On Idle: Sleeping " + str(interval_seconds) + " Seconds...")
            time.sleep(interval_seconds)

    console_log("DNS scan(s) Finished, Completed: " + str(len(DNS_scans)))
    console_log("Good Bye!, Have a Nice Day :)")



if __name__ == '__main__':
    main()
