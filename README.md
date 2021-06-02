# DNSScaner
Distributed zdns implementation

### ---

### Set Up Instructions

1. Create a Service Account and Give Owner Role to the Account OR Just Give the Minimum Roles Required to Function
    * Compute Admin
    * Compute Instance Admin (beta)
    * Compute Instance Admin (v1)
    * Compute Network Admin
    * Compute Network User
    * Compute OS Admin Login
    * Compute OS Login
    * Service Account Admin
    * Service Account User
    * Owner
    * Storage Admin

2. Download the Service Account JSON Key File the Local Machine - Control Node and Add it the Required Directory
    * Keys Directory

3. Link the Service Account to all the Projects of Interest by adding Service Account's Email to Projects IAM By Giving Owner Role  OR Just Give the Minimum Roles Required to Function (As above mentioned)
    * This Works Accross Multiple Projects Belongs to Different GCP Accounts as well

4. Add all the Projects Details to the Relavent Config Varibale
    * terraform.tfvars -> projects variable

5. Add provider blocks for each project of Interest Manually - Terraform does not support for_each in provider block

6. Set Environment Variable of the Local Machine - Control Node

    ```bash
    export ANSIBLE_HOST_KEY_CHECKING=False
    export GOOGLE_APPLICATION_CREDENTIALS=/home/<path to GCP Service Account Key JSON file>
    ```

7. Create A Private / Public Key Pair for SSH Authentication

    ```bash
    ssh-keygen -t rsa -f ~/.ssh/ssh_key -C ssh_user
    ```

8. Add the File Paths to the Private / Public Key Files to the
    * terraform.tfvars -> ssh_key_public
    * terraform.tfvars -> ssh_key_private

9. Create a GCP Storage Bucket From the Root Project - Where you create the GCP Service Account JSON Key

10. Add or change the configurations in both Terraform (main.tf) and Ansible (ansible.cfg)
    * GCP Locations - vm_nodes
    * Projects Details - projects and provider.tf
    * VM Settings - specs
    * Seed File Name to Downloaded from GC Storage Bucket
    * Output File Directories and Naming / Annotating

11. Run the System By Entering Following Commands

    ```bash
    terraform init

    terraform apply
    ```

12. Destroy the Created Infrastructure

    ```bash
    terraform destroy
    ```

