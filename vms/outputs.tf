output "ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "machine_type" {
  value = aws_instance.ec2_instance.instance_type
}

output "boot_image" {

  value = aws_instance.ec2_instance.ami
}

output "boot_disk_size" {

  value = aws_instance.ec2_instance.placement_partition_number

}


