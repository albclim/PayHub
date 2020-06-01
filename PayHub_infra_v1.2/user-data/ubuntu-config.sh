#! /bin/bash
sudo snap install amazon-ssm-agent --classic
sudo systemctl status snap.amazon-ssm-agent.amazon-ssm-agent.service

sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg
sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce -y

sudo apt-get install remmina -y

sudo apt-get update -y -qq
sudo UCF_FORCE_CONFOLD=1 DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" -qq -y install python-apt
sudo apt-get install awscli -y -q
sudo apt-get install git -y -q
sudo apt-get install -y -qq software-properties-common
sudo apt-get update -y -qq

sudo apt install software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install code
sudo apt update
sudo apt upgrade

sudo apt-get install unzip
https://www.terraform.io/downloads.html
wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip
unzip terraform_0.12.18_linux_amd64.zip
sudo mv terraform /usr/local/bin/

sudo apt-get install x11vnc

cd ~
git clone https://github.com/albclim/PayHub.git
cd PayHub_v1/
git pull
