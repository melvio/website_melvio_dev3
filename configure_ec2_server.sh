#!/usr/bin/env bash

set -e

sudo apt -y update
sudo apt -y upgrade
sudo apt -y install make letsencrypt


install_docker() {
  sudo apt-get -y remove docker docker-engine docker.io containerd runc
  sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

  echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >>/dev/null

  sudo apt-get -y update
  sudo apt-get -y install docker-ce docker-ce-cli containerd.io
}

install_docker

run_nginx() {
  sudo apt -y install nginx-full

  sudo systemctl start nginx

  sudo cp ./nginx/nginx.conf /etc/nginx/nginx.conf

  sudo nginx -s reload
}
