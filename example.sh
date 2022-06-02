#!/bin/bash
 echo "Hello, World" > index.html
 sudo nohup busybox httpd -h / -f -p 80 &

 sudo apt-get install build-essential libssl-dev
 curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
 source ~/.bashrc
 nvm install 16.15.0
 sudo apt install curl
 curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
 sudo apt install -y nodejs

 git clone -b peach --single-branch https://github.com/cs-devops-bootcamp/devops-01-Final-TeamB-Senario-01.git
 cd devops-01-Final-TeamB-Senario-01/
 npm install body-parser dotenv express mysql nodemon
