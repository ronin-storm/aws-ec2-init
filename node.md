# 子节点机器初始化配置

## CMD

**子节点机器环境初始化**

```bash
curl -o- https://raw.githubusercontent.com/ronin-storm/aws-ec2-init/main/node-init.sh | bash
```

## HTTPS

```bash
certbot --nginx
```

## Nginx Conf

### 子节点机器环境配置

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

### Gateway 转发

```bash
server {
    listen 80;
    server_name drive.progo.cc;

    location / {
    proxy_pass http://43.152.214.237;
    proxy_http_version 1.1;
    proxy_set_header Host $http_host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

## 其他项

依赖安装

```bash
# 安装 supervisor
sudo yum install python-setuptools
sudo easy_install supervisor

# 初始化全局配置文件
sudo touch /etc/supervisord.conf
sudo echo_supervisord_conf > /etc/supervisord.conf
```

编辑全局配置文件：

```bash
sudo vim /etc/supervisord.conf
```

将文件底部的 `[include]` 分区注释符号 `;` 删除，加入新的配置文件包含路径：
```bash
[include]
files = /etc/supervisor/conf/*.conf
```

创建 Cloudreve 应用配置所在文件目录，并创建打开配置文件：

```bash
sudo mkdir -p /etc/supervisor/conf
sudo vim /etc/supervisor/conf/cloudreve.conf
```

粘贴以下内容

```bash
[program:cloudreve]
directory=/data
command=/data/cloudreve
autostart=true
autorestart=true
stderr_logfile=/var/log/cloudreve.err
stdout_logfile=/var/log/cloudreve.log
environment=CODENATION_ENV=prod
```

通过全局配置文件启动 supervisor：

```bash
supervisord -c /etc/supervisord.conf
```

日后你可以通过以下指令管理 Cloudreve 进程：

```bash
# 启动
sudo supervisorctl start cloudreve

# 停止
sudo supervisorctl stop cloudreve

# 查看状态
sudo supervisorctl status cloudreve
```
