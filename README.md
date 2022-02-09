# AWS EC2 Instance Init

> AWS EC2 机器初始化

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
    rewrite ^(.*) https://$server_name$1 permanent;

    location / {
        proxy_pass http://localhost:3000;
    }
}
```
