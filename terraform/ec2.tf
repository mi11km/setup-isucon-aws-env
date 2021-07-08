resource "aws_instance" "main_server" {
  ami = var.ami_id
  instance_type = "t2.micro"
  tags = {
    Name = "ISUCONTestServer"
  }
  key_name = var.key_name
  vpc_security_group_ids = [
    aws_security_group.defalut_security_group.id]
  subnet_id = aws_subnet.default_public_subnet.id
}

output "ip_address_main" {
  value = aws_instance.main_server.public_ip
}

//resource "aws_instance" "sub_server1" {
//  ami = var.ami_id
//  instance_type = "t2.micro"
//  tags = {
//    Name = "ISUCONTestServer"
//  }
//  key_name = var.key_name
//  vpc_security_group_ids = [
//    aws_security_group.defalut_security_group.id]
//  subnet_id = aws_subnet.default_public_subnet.id
//}
//
//output "ip_address_sub1" {
//  value = aws_instance.sub_server1.public_ip
//}
//
//resource "aws_instance" "sub_server2" {
//  ami = var.ami_id
//  instance_type = "t2.micro"
//  tags = {
//    Name = "ISUCONTestServer"
//  }
//  key_name = var.key_name
//  vpc_security_group_ids = [
//    aws_security_group.defalut_security_group.id]
//  subnet_id = aws_subnet.default_public_subnet.id
//}
//
//output "ip_address_sub2" {
//  value = aws_instance.sub_server2.public_ip
//}