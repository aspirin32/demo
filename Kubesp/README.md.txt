1. Terraform apply

2. Creating 3 servers:1 master k8s, 1 node, 1 srv, ansible-master
then add ip of ansible in inventory and run ansible-playbook -i inventory prepare-ansible-master.yaml

3. Then we shuold have preinstalled ubuntu 22.04 with all requirements.txt from master https://github.com/kubernetes-sigs/kubespray.git (pip install -r requirements.txt)

4. Installing with kubespray:
https://github.com/kubernetes-sigs/kubespray/tree/master
# Copy ``inventory/sample`` as ``inventory/mycluster``
cp -rfp inventory/sample inventory/mycluster

# Update Ansible inventory file with inventory builder
declare -a IPS=(inner ip from outputs after terraform apply)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

# Review and change parameters under ``inventory/mycluster/group_vars``
cat inventory/mycluster/group_vars/all/all.yml
cat inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml

# Clean up old Kubernete cluster with Ansible Playbook - run the playbook as root
# The option `--become` is required, as for example cleaning up SSL keys in /etc/,
# uninstalling old packages and interacting with various systemd daemons.
# Without --become the playbook will fail to run!
# And be mind it will remove the current kubernetes cluster (if it's running)!
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root reset.yml

# Deploy Kubespray with Ansible Playbook - run the playbook as root
# The option `--become` is required, as for example writing SSL keys in /etc/,
# installing packages and interacting with various systemd daemons.
# Without --become the playbook will fail to run!
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml


install gitlab runner
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
sudo apt-get install gitlab-runner


install docker

helm upgrade --install diplomapp .

https://github.com/metal3d/katenary - into helm