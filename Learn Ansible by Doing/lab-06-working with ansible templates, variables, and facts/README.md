Working with Ansible Templates, Variables, and Facts
This course is not approved or sponsored by Red Hat.

The Scenario
A colleague was the unfortunate victim of a scam email, and their network account was compromised. Shortly after we finished helping them pack up their desk, our boss gave us the assignment to promote system security by deploying a hardened sudoers file. We need to create an Ansible template of the sudoers file.

We also need to create an accompanying playbook in /home/ansible/security.yml that will deploy this template to all servers in the default inventory.

Important notes:
Ansible has been installed on the control node.
The user ansible has been already created on all servers with the appropriate shared keys for access to the necessary servers from the control node. It has the same password as cloud_user.
All necessary Ansible inventories have already been created.
Logging In
Log into the control node (control1) as the ansible user, using login credentials on the hands-on lab overview page.

Create a Template sudoers File
[ansible@control1]$ vim /home/ansible/hardened.j2
Now that we're in Vim, we'll put these contents in the file:

%sysops {{ ansible_default_ipv4.address }} = (ALL) ALL
Host_Alias WEBSERVERS = {{ groups['web']|join(' ') }}
Host_Alias DBSERVERS = {{ groups['database']|join(' ') }}
%httpd WEBSERVERS = /bin/su - webuser
%dba DBSERVERS = /bin/su - dbuser
Create a Playbook
[ansible@control1]$ vim /home/ansible/security.yml
The security.yml file should look like this:
```yaml
---
- hosts: all
  become: yes
  tasks:
  - name: deploy sudo template
    template:
      src: /home/ansible/hardened.j2
      dest: /etc/sudoers.d/hardened
      validate: /sbin/visudo -cf %s
```
Run the Playbook
[ansible@control1]$ ansible-playbook /home/ansible/security.yml
The output will show that everything deployed fine, but we can check locally to make sure. Let's become root (with sudo su -) and then read our file:

[ansible@control1]$ sudo cat /etc/sudoers.d/hardened
The custom IP and host aliases are in there.


Learning Objectives
0 of 4 completed

Create a Template *sudoers* File in `/home/ansible/hardened.j2` That Produces a File with Appropriate Output for Each Host
touch /home/ansible/hardened.j2


The Deployed File Should Resemble the Example File Except with the *IP* and *hostnames* Customized Appropriately
Edit hardened.j2 to contain the following text:
```shell
    %sysops {{ ansible_default_ipv4.address }} = (ALL) ALL
    Host_Alias WEBSERVERS = {{ groups['web']|join(', ') }}
    Host_Alias DBSERVERS = {{ groups['database']|join(', ') }} 
    %httpd WEBSERVERS = /bin/su - webuser
    %dba DBSERVERS = /bin/su - dbuser
```
Create a Playbook in `/home/ansible/security.yml` That Uses the Template Module to Deploy the Template on All Servers in the Default Ansible Inventory After Validating the Syntax of the Generated File
Edit /home/ansible/security.yml to contain the following:
```yaml
---
- hosts: all
  become: yes
  tasks:
  - name: deploy sudo template
    template:
      src: /home/ansible/hardened.j2
      dest: /etc/sudoers.d/hardened
      validate: /sbin/visudo -cf %s
```
Run the Playbook and Ensure the Files Are Correctly Deployed
ansible-playbook /home/ansible/security.yml

Check the local /etc/sudoers.d/hardened on the ansible control node for the correct contents.