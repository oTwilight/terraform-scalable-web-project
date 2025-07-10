#!/bin/bash
apt update
apt install -y nginx
systemctl enable nginx
systemctl start nginx

echo "Hello World from $(hostname -f)" > /var/www/html/index.html
