#Create a target group for the load balancer
resource "aws_lb_target_group" "frontend_lb_target" {
  vpc_id = "${aws_vpc.checkpoint-vpc.id}"
  name = "frontend-lb-target"
  port = 80
  protocol = "HTTP"
  target_type = "instance"

  health_check {
    protocol = "HTTP"
    path = "/"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
  }
  
  tags = {
    Name = "frontend-lb-target"
  }

}

#Create a load balancer frontend-lb
resource "aws_lb" "frontend_lb" {
  name               = "frontend-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.frontend-security-sg.id}"]
  subnets            = ["${aws_subnet.frontend-pub.id}", "${aws_subnet.frontend-backup-pub.id}"]

  tags = {
    Name = "frontend-lb"
  }
}

#Create a load balancer listener
resource "aws_lb_listener" "frontend_lb_listener" {
  load_balancer_arn = "${aws_lb.frontend_lb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.frontend_lb_target.arn}"
    type             = "forward"
  }
}

#Attach an instance to the load balancer
resource "aws_lb_target_group_attachment" "frontend_lb_attach" {
  target_group_arn = "${aws_lb_target_group.frontend_lb_target.arn}"
  target_id        = "${aws_instance.frontend-app.id}"
  port             = 80
}

