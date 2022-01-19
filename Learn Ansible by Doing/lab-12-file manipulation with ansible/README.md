File Manipulation with Ansible
Introduction
A common theme in everyday systems administration is the need to work with system files. It follows that any good configuration management or automation engine must be able to do the same. This exercise challenges students to use Ansible to execute varying tasks on remote systems involving file manipulation.

Log in as the ansible user on the Ansible control node using the information provided in the Credentials section of the hands-on lab page.

Download a file to /tmp on each host in qa-servers and verify the sha256 checksum
Verify the checksum and store it as the CHECKSUM variable:

CHECKSUM=$(curl http://software.xyzcorp.com/enigma-checksum.txt | cut -f1 -d' ')
Download a file to /tmp/ on each host in qa-servers, using the CHECKSUM variable:

ansible qa-servers -m get_url -a "url=http://software.xyzcorp.com/enigma.tgz dest=/tmp/enigma.tgz checksum=sha256:$CHECKSUM"
Extract /tmp/enigma.tgz to /opt/ on all hosts in qa-servers
Run the command:

ansible qa-servers -b -m unarchive -a "src=/tmp/enigma.tgz dest=/opt/ remote_src=yes"
Update a line of text on each server in qa-servers
Update the line of text "DEPLOY_CODE" to "CODE_RED" in /opt/enigma/details.txt on each server in qa-servers:

ansible qa-servers -b -m lineinfile -a "regexp=DEPLOY_CODE line=CODE_RED path=/opt/enigma/details.txt"
Set the group ownership of a directory on each host in qa-servers
Set the group ownership of the directory /opt/enigma/secret/ and each file contained within the directory so that the group owner is protected for each host in qa-servers:

ansible qa-servers -b -m file -a "recurse=yes state=directory path=/opt/enigma/secret group=protected"
Delete a file on all servers
Delete the file /opt/enigma/tmp/deployment-passwords.txt on all servers

ansible all -b -m file -a "state=absent path=/opt/enigma/tmp/deployment-passwords.txt"


Learning Objectives
0 of 5 completed

Become 'ansible' user and then download http://software.xyzcorp.com/enigma.tgz to `/tmp` on each host in qa-servers and verify the sha256 checksum via http://software.xyzcorp.com/enigma-checksum.txt.
Note: This URL only works correctly when accessed on the lab servers. The dmain name DNS entry is overridden in /etc/hosts on each lab server. If you attempt to access it from another system, you will reach a parked domain.

On EACH of the hosts in 'qa-servers' inventory, become the 'ansible' user:

sudo su - ansible
As the 'ansible' user (above), run the following commands on each host in the 'qa-servers':

CHECKSUM=$(curl http://software.xyzcorp.com/enigma-checksum.txt | cut -f1 -d' ')
ansible qa-servers -m get_url -a "url=http://software.xyzcorp.com/enigma.tgz dest=/tmp/enigma.tgz checksum=sha256:$CHECKSUM"

Extract `/tmp/enigma.tgz` to `/opt/` on all hosts in qa-servers.
Run ansible qa-servers -b -m unarchive -a "src=/tmp/enigma.tgz dest=/opt/ remote_src=yes"


Update the line of text "DEPLOY_CODE" in `/opt/enigma/details.txt` to the "CODE_RED" on each server in qa-servers.
Run ansible qa-servers -b -m lineinfile -a "regexp=DEPLOY_CODE line=CODE_RED path=/opt/enigma/details.txt"


Set the group ownership of the directory `/opt/enigma/secret/` and each file contained within the directory so that the group owner is `protected` for each host in qa-servers.
Run ansible qa-servers -b -m file -a "recurse=yes state=directory path=/opt/enigma/secret group=protected"


Delete the file `/opt/enigma/tmp/deployment-passwords.txt` from all servers.
Run ansible all -b -m file -a "state=absent path=/opt/enigma/tmp/deployment-passwords.txt"