# docker-lnmp

## 简介
个人lnmp开发环境dockerfile，线上环境请斟酌使用。

## 使用

1. 克隆项目  
```git clone git@github.com:One2r/docker-env.git```  

2. ```cd docker-env```

2. 编译 PHP 镜像  
```docker build -f php-dockerfile . -t php:7.4-fpm-phalcon```

3. 启动 lnmp compose  
```docker compose -f ./lnmp-docker-compose.yml up```