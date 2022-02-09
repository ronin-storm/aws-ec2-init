#!/usr/bin/env bash

# ******************************************************************************
# Author: Ronin
#
# AWS-EC2-机器初始化
# Run: ./init.sh
# ******************************************************************************

# 其他依赖安装
sudo yum install -y vim wget

# nginx 依赖
sudo yum install -y gcc pcre-devel zlib-devel openssl openssl-devel

# 添加nginx资源
rpm -Uvh  http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm

# nginx 安装
sudo yum install -y nginx

# 启动nginx
sudo systemctl start nginx.service

# 开机启动nginx
sudo systemctl enable nginx.service

# 安装git
yum install -y git

# 安装nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

nvm install 16

nvm alias default node

node -v

npm -v

# cnpm安装
npm install -g cnpm --registry=https://registry.npmmirror.com

# pm2
cnpm i -g pm2

# snapd 依赖安装 
sudo yum install -y epel-release

# snapd安装
sudo yum install -y snapd

# 开机启动 snapd
systemctl enable --now snapd.socket

cd ~/

ln -s /var/lib/snapd/snap /snap

# 安装certbot
snap install --classic certbot

echo '✅ 机器初始化成功。'
echo '⚙️ 自动安装https证书'
echo 'certbot --nginx'
echo '📦 SSH密钥'
echo 'ssh-keygen -t rsa -C "aws-ec2-instance"'
