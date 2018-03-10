FROM centos:latest

LABEL maintainer="1972871083@qq.com"

RUN echo 'LANG="en_US.UTF-8"' > /etc/sysconfig/i18n \
	&& rm -rf /etc/localtime \
	&& ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN for packages in epel-release vim wget make cmake gcc gcc-c++ flex bison file libtool libtool-libs kernel-devel libjpeg libjpeg-devel libpng libpng-devel gd gd-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glib2 glib2-devel bzip2 bzip2-devel libevent libevent-devel curl curl-devel e2fsprogs e2fsprogs-devel libidn-devel openssl openssl-devel gettext gettext-devel gmp-devel libcap lrzsz  ncurses ncurses-devel ntp net-tools; \
	do yum -y install $packages; done
	
RUN yum -y remove php* \
	&& yum -y remove mysql-server mysql \
	&& yum -y remove php-mysql	

WORKDIR /root/Download	
RUN wget http://au1.php.net/get/php-7.1.12.tar.gz/from/this/mirror -O php-7.1.12.tar.gz
RUN tar -xzvf php-7.1.12.tar.gz \
	&& cd php-7.1.12 \ 
	&& ./configure  \
	--prefix=/usr/local/php-7.1.12 \
	--with-config-file-path=/usr/local/php-7.1.12/etc \
	--enable-fpm \
	--with-mysqli=mysqlnd \
	--with-pdo-mysql=mysqlnd \
	--with-iconv-dir \
	--with-freetype-dir \
	--with-jpeg-dir \
	--with-png-dir \
	--with-zlib \
	--with-libxml-dir=/usr \
	--enable-xml \
	--disable-rpath \
	--enable-bcmath \
	--enable-shmop \
	--enable-sysvsem \
	--enable-inline-optimization \
	--with-curl \
	--enable-mbregex \
	--enable-mbstring \
	--enable-ftp \
	--with-gd \
	--enable-gd-native-ttf \
	--with-openssl \
	--with-mhash \
	--enable-pcntl \
	--enable-sockets \
	--with-xmlrpc \
	--enable-zip \
	--enable-soap \
	--without-pear \
	--with-gettext \
	--disable-fileinfo \
	--enable-opcache \
	&& make -j2 \
	&& make install

ADD ./etc/php/php.ini /usr/local/php-7.1.12/etc/php.ini
ADD ./etc/php/php-fpm.conf.default /usr/local/php-7.1.12/etc/php-fpm.conf
ADD ./etc/php/www.conf.default /usr/local/php-7.1.12/etc/php-fpm.d/www.conf

RUN rm -f /usr/bin/php \
	&& rm -f /usr/bin/phpize \
	&& rm -f /usr/bin/php-config

RUN ln -s /usr/local/php-7.1.12 /usr/local/php \
	&& ln -s /usr/local/php/bin/php /usr/bin/php \
	&& ln -s /usr/local/php/bin/phpize /usr/bin/phpize \
	&& ln -s /usr/local/php/bin/php-config /usr/bin/php-config \
	&& rm -rf php-7.1.12*

RUN wget https://getcomposer.org/composer.phar -O composer.phar \
	&& mv composer.phar /usr/local/php/bin/ \
	&& chmod +x /usr/local/php/bin/composer.phar

RUN wget https://openresty.org/download/openresty-1.11.2.5.tar.gz -O openresty-1.11.2.5.tar.gz
RUN tar -xzvf openresty-1.11.2.5.tar.gz \
	&& cd openresty-1.11.2.5 \
	&& ./configure -j2 --prefix=/usr/local/openresty-1.11.2.5 \
	&& make -j2 \
	&& make install
ADD ./etc/openresty/nginx.conf /usr/local/openresty-1.11.2.5/nginx/conf/nginx.conf
RUN ln -s /usr/local/openresty-1.11.2.5 /usr/local/openresty \
	&& rm -rf openresty-1.11.2.5*

RUN wget http://download.redis.io/releases/redis-3.2.11.tar.gz -O redis-3.2.11.tar.gz
RUN tar -xzvf redis-3.2.11.tar.gz \
	&& cd redis-3.2.11 \
	&& make -j2 \
	&& make PREFIX=/usr/local/redis-3.2.11 install \
	&& mkdir /usr/local/redis-3.2.11/etc/
ADD ./etc/redis/redis.conf 	/usr/local/redis-3.2.11/etc/redis.conf
RUN ln -s /usr/local/redis-3.2.11 /usr/local/redis \
	&& rm -rf redis-3.2.11*

RUN wget http://soft.vpser.net/datebase/mysql/mysql-5.7.20.tar.gz -O mysql-5.7.20.tar.gz
RUN wget http://202.115.33.13/soft/lib/boost/boost_1_59_0.tar.gz -O boost_1_59_0.tar.gz
RUN tar -xzvf mysql-5.7.20.tar.gz \
	&& tar -xzvf boost_1_59_0.tar.gz \
	&& cd mysql-5.7.20 \
	&& cmake . -DWITH_BOOST=../boost_1_59_0 \
	-DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
	-DMYSQL_DATADIR=/usr/local/mysql/data \
	-DSYSCONFDIR=/usr/local/mysql/etc \
	-DWITH_INNOBASE_STORAGE_ENGINE=1 \
    -DWITH_PARTITION_STORAGE_ENGINE=1 \
    -DWITH_FEDERATED_STORAGE_ENGINE=1 \
    -DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
    -DWITH_MYISAM_STORAGE_ENGINE=1 \
    -DENABLE_DTRACE=0 \
    -DENABLED_LOCAL_INFILE=1 \
    -DDEFAULT_CHARSET=utf8mb4 \
    -DDEFAULT_COLLATION=utf8mb4_general_ci \
    -DEXTRA_CHARSETS=all \
	&& make -j2 \
	&& make install \
	&& mkdir /usr/local/mysql/etc/ \
	&& cp /usr/local/mysql/support-files/mysql.server /etc/init.d \
	&& mv /etc/init.d/mysql.server /etc/init.d/mysqld \
	&& sed -i "s@^basedir=.*@basedir=/usr/local/mysql@" /etc/init.d/mysqld \
  	&& sed -i "s@^datadir=.*@datadir=/usr/local/mysql/data@" /etc/init.d/mysqld \
	&& chmod +x /etc/init.d/mysqld

ADD ./etc/mysql/my.cnf /usr/local/mysql/etc/my.cnf

RUN groupadd www \
	&& useradd -s /sbin/nologin -g www www \
	&& groupadd mysql \
	&& useradd -s /sbin/nologin -g mysql mysql \ 
	&& mkdir /usr/local/mysql/data \
	&& /usr/local/mysql/bin/mysqld --initialize --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data \
	&& rm -rf mysql-5.7.20* boost_1_59_0*

WORKDIR /root/
EXPOSE 80
EXPOSE 3306
EXPOSE 6379
ADD ./etc/run.sh ./
RUN chmod +x run.sh
CMD /root/run.sh && /bin/bash