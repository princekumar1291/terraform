#!/bin/bash

sudo apt-get update

sudo apt-get install -y nginx

sudo systemctl start nginx

sudo systemctl enable nginx

echo "Hello World from $(hostname -f)" > /var/www/html/index.html