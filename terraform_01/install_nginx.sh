#!/bin/bash

sudo apt-get update

sudo apt-get install -y nginx

sudo systemctl start nginx

sudo systemctl enable nginx

echo "Hello World" > /var/www/html/index.html