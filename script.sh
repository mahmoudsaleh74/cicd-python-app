#!/bin/bash
# script vars
base_path=~/cicd-python-app
terraform_path=${base_path}/terraform
ansible_path=${base_path}/ansible
inventory_file=${ansible_path}/inventory
ssh_key=${base_path}/kamen.pem

# Function to run Terraform
deploy_infrastructure() {
    echo "Deploy infrastructure using terraform..."
    cd "${terraform_path}"
    terraform init
    terraform apply -auto-approve
    instance_ip=$(terraform output jenkins_instance_public_ip)
    echo "Terraform execution completed."
}

# Function to Update inventory
update_inventory() {
    echo "Updating Ansible inventory..."
    if [ -z "${instance_ip}" ]; then
        echo "Error: instance_ip is empty. Make sure Terraform has been executed successfully."
        exit 1
    fi

    # Replace the IP address of the target host in the inventory file
    echo "[server]" > "${inventory_file}"
    echo "server ansible_host=${instance_ip} ansible_ssh_private_key_file=${ssh_key}" > "${inventory_file}"
    echo "Ansible inventory updated."
}

# Function to run Ansible
run_ansible() {
    echo "Running Ansible..."
    cd "${ansible_path}"
    export ANSIBLE_HOST_KEY_CHECKING=False
    ansible-playbook -i inventory playbook.yml
    echo "Ansible execution completed."
}

# Main script
echo "Starting script..."

# Call the functions to start deploying
deploy_infrastructure
update_inventory
echo "Please Wait Until The Server Initialize"
sleep 10
run_ansible
echo "Script execution finished."