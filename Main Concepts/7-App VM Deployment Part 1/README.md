bakcend.tf

```shell
terraform {
  required_version = ">= 0.12.0"
  backend "s3" {
    region  = "us-east-1"
    profile = "default"
    key     = "terraformstatefile" # for s3 bucket file to store data
    bucket  = "terraformstatebucket6655"
  }
}
````

To download state file from s3 bucket run the following command
```shell

aws s3 cp s3://terraformstatebucket6655/terraformstatefile .

```
And you can see the contents of the file, search aws_ssm_paramets
from this you can see AMI iD
