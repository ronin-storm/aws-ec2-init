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

## Https

```bash
certbot --nginx
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

```bash
upstream upstream_name{
    server 49.232.196.238;
}
server {
    listen 80;
    server_name drive.progo.cc;
    add_header 'Access-control-AlLow-Origin' '*';
    add_header 'Access-Control-Allow-Methods' 'GET,POST,OPTIONS';
    add_header 'Access-Control-Allow-Headers' 'Origin,X-Requested-With,Content-Type,Accept,Authorization';

    location / {
        proxy_pass http://upstream_name;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
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
