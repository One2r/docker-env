# docker-env

## 简介
常用 web 环境 docker 配置。

## 使用

1. 克隆项目  
```git clone git@github.com:One2r/docker-env.git```  

2. ```cd docker-env```

2. 编译镜像  
    - PHP 镜像  
    ```
    docker build --force-rm=true -f ./dockerfiles/php/7.4-dockerfile . -t php:my-7.4-fpm
    docker build --force-rm=true -f ./dockerfiles/php/8.2-dockerfile . -t php:my-8.2-fpm
    ```
    - jupyterhub 镜像  
    ```docker build --force-rm=true -f ./dockerfiles/jupyterhub-dockerfile . -t jupyterhub:my-jupyterhub```
    - openresty gateway 镜像   
    ```docker build --force-rm=true -f ./dockerfiles/gateway-dockerfile . -t openresty:gateway```
    - redis with plugin 镜像   
    ```docker build --force-rm=true -f ./dockerfiles/redis-dockerfile . -t redis:6-with-plugin```

3. 创建容器网络   
```docker network create --subnet=192.168.1.0/24 dev```   

4. ```cp .env.example .env```，编辑 ```.env```，修改数据目录和工作代码目录

5. 启动服务
    - web gateway  
    ```docker compose -f ./gateway-compose.yml up```

    - php 环境  
    ```docker compose -f ./phpenv-compose.yml up```

    - skywalking  
    ```docker compose -f ./skywalking-docker-compose.yml up```

99. 其他 
- ELK 使用 ```git@github.com:deviantony/docker-elk.git``` 项目
