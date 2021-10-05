### Setting Up the Environment Terraform

- Download the Terraform binary for your OS from Hashicorp website
    ```shell
    wget <Hashicorp url for downloading terraform>
    unzip <terraform binary>
    ```
- Place it in the PATH of the OS for ease of access
    Test and verify the binary
    ```shell
    mv tarraform /usr/local/bin
    terraform version 
    ```
### Setting Up the Environment AWS CLI and Ansible 
  - Depending on the OS install Python's pip (Python's package installer) using yum, apt-get, dnf)
    ```shell
    sudo yum -y install python3-pip
    ```
  - Use pip to install AWS CLI and Ansible (pip install <package name>)
    ```shell
    pip3 install awscli --user
    ```
  - Download a preconfigured Ansible config file [link]()
    ```shell
    pip3 install ansible --user
    mkdir deploy_to_iac_tf_ansible
    cd deploy_to_iac_tf_ansible
    wget https://raw.githubusercontent.com/linuxacademy/content-deploying-to-aws-ansible-terraform/master/aws_la_cloudplayground_version/ansible.cfg
    aws version
    ansible version
    aws configure
    ```
  - Configure AWS CLI (aws configure)


### AWS IAM Permissions For Terraform

- Terraform will need permissions to create, update and delete various AWS resoures
- You can do either of the following depending on how you're deploying
  **- a) Create a seperate IAM user with required permissions**
  **- b) Create an EC2 (IAM role) instance profile with required permissions and attach it to EC2.**

At the least, we'll need IAM permissions described by the IAM policy available in the resource section of this video. We can then do one of the following:

Create an EC2 role and attach an instance profile to an EC2 instance to work within AWS.
Attach the IAM policy directly to an IAM user created for this deployment and configure AWS CLI with it's credentials to allow Terraform permissions to deploy in AWS.

**Method 1:**
- IAM -> Policies -> Create Policy -> JSON paste all contenst (fom link) [Custom Strict Policy for AWS deployment via Terraform for this course](https://raw.githubusercontent.com/linuxacademy/content-deploying-to-aws-ansible-terraform/master/iam_policies/terraform_deployment_iam_policy.json) -> Review -> terraformUserPolicy -> Create Policy 

**Method 2:**
- IAM -> Users -> Add User (Name: terraformUser, Access type: Programmatic access) -> Next -> Attach existing policies directly -> TerraformUserpolicy (put a tick) -> Add tag (Key: Name, Value: TFPolicy) -> Next -> Create User
- From here you can get Access key ID and Secret access key 
- the second method create a role and attach it to a ec2 instance 
- IAM -> Roles -> Create Role -> AWS service (Common use cases - EC2) -> Next permissions (search terraformUserPolicy and put a tick) -> Add tag (Key: Name, Value: RoleEC2TF) -> Next (Role name: RoleEC2TF) -> Create Role

[Custom Relaxed Policy for AWS Deployment via Terraform](https://raw.githubusercontent.com/linuxacademy/content-deploying-to-aws-ansible-terraform/master/iam_policies/terraform_deployment_lax_iam_policy.json)