1. **terraform init** 
   - initializes terraform projects in working directory - download required plugins from public or private registry
   - can not deploy anthing without running this command
   - configure backend for storing infrastructure state

2. **terraform fmt** 
   - format your code to be more readable and stylish
   - it will arrange your code in place
   - not modified deleted, updated and such action

3. **terraform validate** 
   - checks for syntax mistakes
   - checks typos and misconfigured resources
   - before this command running need to be run init command

4. **terraform plan** 
   - create execution plan 
   - checks connecntivity with provider which is written in terraform configuration file
   - checks connectivity with API and credintials that we provided 
   - it refreshes terraform state resources
   - it is fail-safe that's before you actual deployment to create real resources 

5. **terraform apply** 
   - applies the changes required to achieve desired state of Terraform code
   - by default the user need to type in "yes" explicitly before any infrastructure is deployed

