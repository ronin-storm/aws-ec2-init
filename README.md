# AWS EC2 Instance Init

> AWS EC2 机器环境初始化

安装项：
- Nginx
- Git
- Certbot(https)
- nvm
- Nodejs
- cnpm
- pm2

## CMD

```bash
curl -o- https://raw.githubusercontent.com/ronin-storm/aws-ec2-init/main/init.sh | bash
```

## Nginx Conf

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

## Iptables

```bash
iptables -I INPUT -p tcp --dport 3000 -j ACCEPT
```
