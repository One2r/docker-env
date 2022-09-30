# docker-lnmp

## 简介
常用开发环境 docker 配置，线上环境请斟酌使用。

## 使用

1. 克隆项目  
```git clone git@github.com:One2r/docker-env.git```  

2. ```cd docker-env```

2. 编译 PHP 镜像  
```docker build --force-rm=true -f php-dockerfile . -t php:7.4-fpm-phalcon```

3. 创建容器网络   
```docker network create --subnet=172.32.1.0/24 dev```

4. 启动 lnmp compose  
```docker compose -f ./lnmp-docker-compose.yml up```

5. 启动 skywalking compose  
```docker compose -f ./skywalking-docker-compose.yml up```

6. 执行 php cli   
```docker run -it --rm --name php -v /path/to/project/:/usr/src/myapp -w /usr/src/myapp php:7.4-fpm-phalcon php run```
