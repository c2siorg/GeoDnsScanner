projects = {
    # DNSIP03
    ADNS_Project_01: "fluid-mix-301105"
    ADNS_Project_02: "adns-project-03"
    ADNS_Project_03: "adns-project-04"
    # DNSIP04
    ADNS_Project_04: "adns-project-01-303514"
}

SSH_usernames = {
    user_01: "dsnip04"
}

# List All the VMs Need
vm_nodes = {
    node_01: {project_id: "fluid-mix-301105", region: "us-central1", zone: "us-central1-c", vm_name:"terra-ansi-instance-01"}
    node_02: {project_id: "adns-project-03", region: "asia-east2", zone: "asia-east2-a", vm_name:"terra-ansi-instance-02"}
    # node_03: {project_id: "adns-project-03", region: "us-central1", zone: "us-central1-c", vm_name:"terra-ansi-instance-03"}
    # node_04: {project_id: "adns-project-04", region: "us-central1", zone: "us-central1-c", vm_name:"terra-ansi-instance-04"}
    # node_05: {project_id: "adns-project-04", region: "us-central1", zone: "us-central1-c", vm_name:"terra-ansi-instance-05"}
    # node_06: {project_id: "adns-project-04", region: "us-central1", zone: "us-central1-c", vm_name:"terra-ansi-instance-06"}
    # node_07: {project_id: "adns-project-04", region: "us-central1", zone: "us-central1-c", vm_name:"terra-ansi-instance-07"}
}

SSH_user = "ssh_user"
playbook = "test-playbook.yaml"