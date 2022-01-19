Deploying Ansible
We have been tasked with putting together a presentation to demonstrate how Ansible may be used to install software on remote hosts automatically.

Install Ansible on the Control Host
Log in to the Control Host server using ssh, cloud_user, and the provided Public IP address and password:

ssh cloud_user@<PUBLIC IP>
Install epel-release and enter y when prompted:

sudo yum install epel-release
Install Ansible and enter y when prompted:

sudo yum install ansible
Create an ansible User
Now, we need to create the ansible user on both the control host and workstation host.

On the control node:

sudo useradd ansible
Connect to the workstation node using the provided password:

ssh workstation
Add the ansible user to the workstation and set a password for the ansible user. We need to make sure it is something we will remember:

sudo useradd ansible
sudo passwd ansible
logout
Configure a Pre-Shared Key for Ansible
With our user created, we need to create a pre-shared key that allows the user to log in from control to workstation without a password.

Change to the ansible user:

sudo su - ansible
Generate a new SSH key, accepting the default settings when prompted:

ssh-keygen
Copy the SSH key to workstation, providing the password we created earlier:

ssh-copy-id workstation
Test that we no longer need a password to log in to the workstation:

ssh workstation
Once we succeed at logging in, log out of workstation:

logout
Configure the Ansible User on the Workstation Host
Our next job is to configure the ansible user on the workstation host so that that they may sudo without a password.

Log in to the workstation host as cloud_user using the password provided by the lab:

ssh cloud_user@workstation
Edit the sudoers file:

sudo visudo
Add this line at the end of the file:

ansible       ALL=(ALL)       NOPASSWD: ALL
Save the file:

:wq
Log out of workstation:

logout
Create a Simple Inventory
Next, we need to create a simple inventory, /home/ansible/inventory, consisting of only the workstation host.

On the control host, as the ansible user, run the following commands:

vim /home/ansible/inventory
Add the text "workstation" to the file and save using :wq in vim.

Write an Ansible Playbook
We need to write an Ansible playbook into /home/ansible/git-setup.yml on the control node that installs git on workstation, then executes the playbook.

On the control host, as the ansible user, create an Ansible playbook:

vim /home/ansible/git-setup.yml
Add the following text to the file:

--- # install git on target host
- hosts: workstation
  become: yes
  tasks:
  - name: install git
    yum:
      name: git
      state: latest
Save and exit the file (:wq in vim).

Run the playbook:

ansible-playbook -i /home/ansible/inventory /home/ansible/git-setup.yml
Verify that the playbook ran successfully:

ssh workstation
which git

```yaml
--- # install git on target host
- hosts: workstation
  become: yes
  tasks:
  - name: install git
    yum:
      name: git
      state: latest
  - name: ensure nginx is at the latest version
    yum: 
      name: nginx
      state: installed
  - name: copy the nginx conf file and restart it
    copy:
      src: /home/ansible/nginx-conf/nginx.conf
      dest: /etc/nginx/sites-available/nginx.conf
    become: yes
  - name: create symlink
    file:
      src: /etc/nginx/sites-available/nginx.conf
      dest: /etc/nginx/sites-enabled/default
      state: link
    become: yes
  - name: restart nginx
    service:
      name: nginx
      state: restarted          
    become: yes
```



### Learning Objectives
0 of 6 completed

Install Ansible on the control host.
Run the following commands on the control host:

sudo yum install epel-release

sudo yum install ansible


Create an `ansible` user on both the control host and workstation host being sure to set a password you can remember.
On each host, run the noted commands below. Make sure you set a password you can remember (you will need it later).

Assuming you are logged in as cloud_user:

sudo useradd ansible

sudo passwd ansible


Configure a pre-shared key for Ansible that allows the user to log in from `control` to `workstation` without a password.
Assuming you are logged into control as cloud_user, run the following commands providing the appropirate passwords when prompted and default options otherwise:

sudo -i -u ansible (provide cloud_user a sudo password)

ssh-keygen (accept default options by pressing enter )

ssh-copy-id workstation (provide ansible user a password)

logout


Configure the Ansible user on the workstation host so that Ansible may sudo without a password.
Log into the workstation host as cloud_user and run the following commands:
sudo visudo
Add text at the end of the file that is opened:
ansible ALL=(ALL) NOPASSWD: ALL
Save file:
(:wq in vim)

Create a simple inventory in `/home/ansible/inventory` consisting of only the `workstation` host.
On the control host as the ansible user run the following commands:

vim /home/ansible/inventory (note: you may use any text editor with which you are comfortable)

Add the text "workstation" to the file and save using (:wq in vim).

Write an Ansible playbook in `/home/ansible/git-setup.yml` on the control node that installs `git` on `workstation` then execute the playbook.
On the control host as the ansible user run the following commands:
vim /home/ansible/git-setup.yml (You may use any text editor with which your are comfortable.)
Add the following text to the file:
    --- # install git on target host
    - hosts: workstation
      become: yes
      tasks:
      - name: install git
        yum:
          name: git
          state: latest
Save (:wq in vim) and quit the text editor.

Run ansible-playbook -i /home/ansible/inventory /home/ansible/git-setup.yml.