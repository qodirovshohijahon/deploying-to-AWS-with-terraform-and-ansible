Working with Confidential Data in Ansible
This course is not approved or sponsored by Red Hat.

Introduction
The Red Hat Certified Ansible Specialist Exam (EX407) requires an understanding of working with confidential data within Ansible. This hands-on lab goes over how you can use the ansible-vault command to encrypt sensitive files within a vault file and also how to work with those vault files in an Ansible playbook. The exercise assumes basic proficiency with several common ansible modules and general ansible playbook use. Upon completing the lab, you will have developed an improved understanding of ansible-vault and vault files.

Solution
Log in to the Ansible Control Node via SSH:

ssh cloud_user@<PUBLIC IP>
Switch to the ansible account (same password as the control node):

su ansible
Encrypt /home/ansible/secret
Encrypt the file:

ansible-vault encrypt /home/ansible/secret
Give it an easy-to-remember new password, since we'll need it again later.

Create a Vault Password File
Configure a vault password file named /home/ansible/vault to be used to run the Ansible playbook (replacing <YOUR VAULT PASSWORD> with the one you just created):

echo "<YOUR VAULT PASSWORD>" > /home/ansible/vault
Run the Playbook
Run the playbook /home/ansible/secPage.yml using your vault password file to validate your work:

ansible-playbook --vault-password-file /home/ansible/vault /home/ansible/secPage.yml
Verify the Secure Page Deployed Correctly
In the terminal, enter:

curl -u bond http://node1/secure/classified.html
When prompted for the password, enter james.

The command should return the contents of classified.html regarding the weather in a certain city.

Conclusion



Learning Objectives
0 of 4 completed

Encrypt `/home/ansible/secret` using the `ansible-vault` command.
Switch to the ansible user with su ansible
Run ansible-vault encrypt /home/ansible/secret and provide a simple password of your choosing.
Be sure to remember the password!

Create */home/ansible/vault* as a vault password file that may be used to access the encrypted secret file without prompt.
Run the command echo "<Your_Vault_Password>" > /home/ansible/vault.
Substitute <<Your_Vault_Password>Your_Vault_Password> with the password you chose in the previous task.

Run the playbook */home/ansible/secPage.yml* using your *vault* password file to validate your work.
Run the command ansible-playbook --vault-password-file /home/ansible/vault /home/ansible/secPage.yml.
If your encryption was configured correctly, you should get no errors.

Verify that the secure page deployed correctly by attempting to access http://node1/secure/classified.html as the user *bond* with the password *james*.
Run curl -u bond http://node1/secure/classified.html and supply the password james when prompted.
The command should return the contents of classified.html regarding the weather in a certain city.