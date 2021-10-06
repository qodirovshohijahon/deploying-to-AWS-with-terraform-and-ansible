output "Jenkins-Main-Node-Public-IP" {
    value = aws_instance.jenkins-master.public_ip
}

output "Jenkins-Worker-Public-IPs" {
    value = {
        for instance in aws_instance.jenkins-worker-oregon :
        instance_id => instance.public_ip
    }
}