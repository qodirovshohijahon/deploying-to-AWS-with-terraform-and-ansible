### Setting Up the Environment Terraform

- Download the Terraform binary for your OS from Hashicorp website
  - wget <Hashicorp url for downloading terraform>
  - unzip <terraform binary>
- Place it in the PATH of the OS for ease of access
    Test and verify the binary
  - mv tarraform /usr/local/bin
  - terraform version 

### Setting Up the Environment AWS CLI and Ansible 
  - Depending on the OS install Python's pip (Python's package installer) using yum, apt-get, dnf)
    - sudo yum -y install python3-pip
  - Use pip to install AWS CLI and Ansible (pip install <package name>)
   ```shell
        pip3 install awscli --user
   ```
  - Download a preconfigured Ansible config file [link]()
    - pip3 install ansible --user
  - Configure AWS CLI (aws configure)
