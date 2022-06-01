#!/bin/bash
echo "Hello, World" > index.html
sudo nohup busybox httpd -h / -f -p 80 &