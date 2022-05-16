#!/usr/bin/env bash

# ******************************************************************************
# Author: Ronin
#
# 子节点机器初始化
# Run: ./node-init.sh
# ******************************************************************************

# 其他依赖安装
sudo yum install -y vim wget unzip zip

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

sleep 3

# 重试
sudo snap install --classic certbot

sudo ln -s /snap/bin/certbot /usr/bin/certbot

echo '✅ certbot 安装成功。'

cd /data

# 安装其他aria2自动部署脚本
echo '🎁 开始安装其他aria2自动部署脚本'

# 依赖安装
sudo yum install -y wget curl ca-certificates

# 脚本下载执行
wget -N git.io/aria2.sh && chmod +x aria2.sh

echo '🎉 系统初始化成功！'

