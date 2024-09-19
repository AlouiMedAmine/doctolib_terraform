#!/bin/bash
#sudo yum -y install httpd
#sudo systemctl start httpd && sudo systemctl enable httpd
#"echo '<h1><center>My Test Website With Help From Terraform Provisioner</center></h1>' > index.html",
#     "sudo mv index.html /var/www/html/



sudo yum update -y
sudo yum install git -y
sudo amazon-linux-extras install nginx1.12
sudo systemctl start nginx sudo systemctl enable nginx
sudo vim /etc/nginx/sites-enabled/fastapi_nginx
git clone https://github.com/AlouiMedAmine/doctolib_fastapi.git
pip3 install fastapi uvicorn
cd doctolib_fastapi/backend
uvicorn main:app --reload