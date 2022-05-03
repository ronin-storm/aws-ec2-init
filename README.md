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

**完整服务器环境初始化**

```bash
curl -o- https://raw.githubusercontent.com/ronin-storm/aws-ec2-init/main/init.sh | bash
```

**子节点机器环境初始化**

```bash
curl -o- https://raw.githubusercontent.com/ronin-storm/aws-ec2-init/main/node-init.sh | bash
```

## HTTPS

```bash
certbot --nginx
```

## Nginx Conf

**普通机器环境配置**

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

**子节点机器环境配置**
```bash
server {
    listen       80;
    server_name  progo.cc;

    location / {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_redirect off;
        proxy_pass http://127.0.0.1:5212;

        # 如果您要使用本地存储策略，请将下一行注释符删除，并更改大小为理论最大文件尺寸
        # client_max_body_size 20000m;
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
