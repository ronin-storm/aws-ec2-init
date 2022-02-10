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

# 更改时区
timedatectl set-timezone Asia/Shanghai

# nginx 安装
sudo yum install -y nginx

# 启动nginx
sudo systemctl start nginx.service

# 开机启动nginx
sudo systemctl enable nginx.service

echo '✅ nginx 安装成功。'

# 安装git
yum install -y git

echo '✅ git 安装成功。'

# 安装nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

echo '✅ nvm 安装完毕。'

nvm install 16

nvm alias default node

node -v

npm -v

echo '✅ node 默认版本设置完毕。'

# cnpm安装
npm install -g cnpm --registry=https://registry.npmmirror.com

echo '✅ cnpm 安装成功。'

# pm2
cnpm i -g pm2

echo '✅ pm2 安装成功。'

# snapd 依赖安装 
sudo yum install -y epel-release

# snapd安装
sudo yum install -y snapd

# 开机启动 snapd
systemctl enable --now snapd.socket

echo '✅ snapd 安装成功。'

sudo ln -s /var/lib/snapd/snap /snap

# 安装certbot
sudo snap install --classic certbot

sudo ln -s /snap/bin/certbot /usr/bin/certbot

echo '✅ certbot 安装成功。'

mkdir ~/service

echo
echo
echo '-------------------------'
echo
echo '✅ 机器初始化成功。'
echo
echo '⚙️  自动安装https证书'
echo 'certbot --nginx'
echo
echo '📦 SSH 密钥生成'
echo 'ssh-keygen -t rsa -C "aws-ec2-instance"'
echo
echo '-------------------------'
