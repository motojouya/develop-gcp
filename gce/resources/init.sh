#!/bin/bash
set -x

# definitions
username=$1
ssh_port=$2

# start configurations
cd /home/ubuntu

# ssh config
curl https://raw.githubusercontent.com/motojouya/develop-gcp/main/gce/resources/sshd_config.tmpl -O
sed -e s/{%port%}/$ssh_port/g sshd_config.tmpl > sshd_config.init
cp sshd_config.init /etc/ssh/sshd_config
systemctl restart sshd

apt-get update
apt-get install -y jq
apt-get install -y tmux
apt-get install -y tree
apt-get install -y xauth

apt-add-repository -y ppa:mizuno-as/silversearcher-ag
apt-get update -y
apt-get install -y silversearcher-ag

apt-get install -y nvme-cli

# # gcloud
# export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
# echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
# apt-get update
# apt-get install -y google-cloud-sdk

# # install nodejs
# apt-get install -y nodejs
# apt-get install -y npm
# 
# curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
# echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# apt-get update
# apt-get install -y yarn
# npm install -g npx
# npm install -g typescript typescript-language-server

# # install docker
# apt-get install -y \
#     apt-transport-https \
#     ca-certificates \
#     curl \
#     gnupg-agent \
#     software-properties-common
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
# apt-key fingerprint 0EBFCD88
# add-apt-repository \
#    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
#    $(lsb_release -cs) \
#    stable"
# apt-get update
# apt-get install -y docker-ce docker-ce-cli containerd.io
# 
# curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
# chmod +x /usr/local/bin/docker-compose
# 
# gpasswd -a $username docker
# systemctl restart docker

# # others
# /home/$username/.fzf/install --bin

