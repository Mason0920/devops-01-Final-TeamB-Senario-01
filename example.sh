#!/bin/bash
echo '---cron 실행---'
cd /home/ubuntu/cashbook-03
git fetch origin main
git pull origin main

lastCommit=$(cat /home/ubuntu/last-commit.info)
current=$(git rev-parse origin)

if [[ $current != $lastCommit ]];
then
  echo '---커밋변경 배포절차 실행---'
  echo '---client build---'
  cd ./client
  sudo npm i
  sudo npm run build
  sudo cp -r dist/* /var/www/html/
  sudo service nginx restart

  echo '---server build---'
  cd ../server
  sudo npm i
  sudo npm run build

  echo '---pm2 reload account---'
  sudo pm2 reload all

  # 기존 커밋 덮어쓰기
  echo '---update lastCommit.info---'
  echo $current > /home/ubuntu/last-commit.info
fi

# echo "Hello, World" > index.html
# sudo nohup busybox httpd -h / -f -p 80 &