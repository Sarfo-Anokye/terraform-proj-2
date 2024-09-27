resource "aws_key_pair" "ec2_auth" {
  key_name   = "my_ssh_key_pair"
  public_key = file("./my-ssh-key-pair.pub")

}

resource "aws_instance" "dev_node" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.public_ec2_ami.id
  key_name               = aws_key_pair.ec2_auth.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  subnet_id              = aws_subnet.my_public_subnet.id
  user_data              = file("./userdata.tpl")


  root_block_device {
    volume_size = 10
  }
  tags = {
    Name = "dev_node"

  }


}