In this video, we go about deploying the HTTPS endpoint for our application. We do this by adding an HTTPS listener to the ALB we created in the previous lesson. We generate an SSL certificate to attach to the ALB HTTPS listener so that HTTPS traffic can be terminated at the ALB. We put a DNS domain in front of our load balancer and also enable http to https redirection.

Note: If you are following along in A Cloud Guru's provided Cloud Playground AWS Sandbox, your temporary AWS account should come with a public domain which has the following expression where xxx is a random three-digit number.

`cmcloudxxx.info`

(If you do not see the `cmcloudxxx.info` domain in HostedZone please delete the AWS Sandbox and start a new Sandbox.)

If you're using Cloud Playground or your own AWS account with a personal domain, issue the following command to fetch the domain:

```shell
    aws route53 list-hosted-zones
```

Look for Name under the HostedZone field in the output of the above command.  