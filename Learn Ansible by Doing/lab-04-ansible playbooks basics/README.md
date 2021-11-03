Ansible Playbooks - the Basics
This course is not approved or sponsored by Red Hat.

The Scenario
Our company has been increasing the deployment of small brochure-style websites for clients. The head of IT has decided that each client should have their own web server, for better client isolation, and has tasked us with creating concept automation to quickly deploy web-nodes with simple static website content.

We have been provided an Ansible control node (control1) and 2 test lab servers (node1 and node2) that have been preconfigured with the ansible user and key.

We must create an Ansible inventory in /home/ansible/inventory containing a host group named web. The web group should contain node1 and node2.

Then we've got to design an Ansible playbook that will execute the following tasks on your configured inventory:

Install httpd
Start and enable the httpd service
Install a simple website provided on a repository server.
The playbook will be in /home/ansible/web.yml. The simple website may be accessed from http://repo.example.com/website.tgz.

Get Logged In
Login credentials are all on the lab overview page. Once we're logged into the control1 server, become the ansible user (su - ansible) and we can get going.

Create an inventory in /home/ansible/inventory That Contains a Host Group Named web. The web Group Should Contain node1 and node2
Use Vim to create the inventory file:

[ansible@control1]$ echo "[web]" >> /home/ansible/inventory
It should contain this when we're done:

[web]
node1
node2
Create a Playbook in /home/ansible/web.yml
Using Vim, we'll create our web.yml file with these contents:
```yaml
---
- hosts: web
  become: yes
  tasks:
    - name: install httpd
      yum: name=httpd state=latest
    - name: start and enable httpd
      service: name=httpd state=started enabled=yes
    - name: retrieve website from repo
      get_url: url=http://repo.example.com/website.tgz dest=/tmp/website.tgz
    - name: install website
      unarchive: remote_src=yes src=/tmp/website.tgz dest=/var/www/html/
```

Verify the Work by Executing the Playbook Using the Inventory
[ansible@control1]$ansible-playbook -i /home/ansible/inventory /home/ansible/web.yml




Learning Objectives
0 of 7 completed

Create an Inventory in `/home/ansible/inventory `That Contains a Host Group Named `web`. The `web` Group Should Contain `node1` and `node2`
echo "[web]" >> /home/ansible/inventory
echo "node1" >> /home/ansible/inventory
echo "node2" >> /home/ansible/inventory

Create a Playbook in `/home/ansible/web.yml`
echo "---" >> /home/ansible/web.yml


Configure the Playbook to Install `httpd` on the `web` Group
Using a text editor, such as vim, edit /home/ansible/web.yml to contain the following text block below the line containing "---": - hosts: web become: yes tasks: - name: install httpd yum: name=httpd state=latest


Configure the Playbook to Start and Enable the `httpd` Service on the `web` Group
Using a text editor such as vim, edit /home/ansible/web.yml to contain the following task block after the "install httpd task": - name: start and enable httpd service: name=httpd state=started enabled=yes


Configure the Playbook to Retrieve the Website from *http://repo.example.com/website.tgz* on Each Server in the `web` Group
Using a text editor such as vim, edit /home/ansible/web.yml to contain the following task block after the "start and enable httpd" task: - name: retrieve website from repo get_url: url=http://repo.example.com/website.tgz dest=/tmp/website.tgz


Configure the Playbook to Unarchive the Website into `/var/www/html` on All Servers in the `web` Group
Using a text editor such as vim, edit /home/ansible/web.yml to contain the following task block after the "retrieve website from repo" task: - name: install website unarchive: remote_src=yes src=/tmp/website.tgz dest=/var/www/html/


Verify the Work by Executing the Playbook Using the Inventory
ansible-playbook -i /home/ansible/inventory /home/ansible/web.yml