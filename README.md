# AWS EC2 Instance Init

> AWS EC2 机器环境初始化
> 子节点机器初始化：[点击前往](./node.md)

安装项：
- Nginx
- Git
- Certbot(https)
- nvm
- Nodejs
- cnpm
- pm2

## CMD

**完整服务器环境初始化**

```bash
curl -o- https://raw.githubusercontent.com/ronin-storm/aws-ec2-init/main/init.sh | bash
```

## HTTPS

```bash
certbot --nginx
```

## Nginx Conf

### 普通机器环境配置

```bash
server {
    listen       80;
    server_name  progo.cc;

    location / {
        proxy_pass http://localhost:3000;
    }
    
    location /favicon.ico{
	return 200;
	access_log off;
     }
}
```

## Network

```bash
iptables -I INPUT -p tcp --dport 3000 -j ACCEPT
```

```bash
setsebool -P httpd_can_network_connect 1
```
