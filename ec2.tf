resource "aws_instance" "web" {
    ami = "ami-013168dc3850ef002"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.demo_subnet.id
    vpc_security_group_ids = [aws_security_group.demo-vpc-sg.id]
    
    tags = {
        Name = "Myec2"
    }
}