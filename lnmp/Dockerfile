FROM centos:latest

RUN yum -y install yum-fastestmirror \
 	&& yum -y update

RUN echo 'LANG="en_US.UTF-8"' > /etc/sysconfig/i18n \
	&& rm -rf /etc/localtime \
	&& ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN for packages in epel-release psmisc vim patch wget  make cmake gcc gcc-c++ gcc-g77 flex bison file libtool libtool-libs autoconf kernel-devel libjpeg libjpeg-devel libpng libpng-devel libpng10 libpng10-devel gd gd-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glib2 glib2-devel bzip2 bzip2-devel libevent libevent-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel vim-minimal nano fonts-chinese gettext gettext-devel ncurses-devel gmp-devel pspell-devel unzip libcap lrzsz screen rsync libmcrypt-devel ntp net-tools; \
	do yum -y install $packages; done \
	&& ntpdate -u pool.ntp.org
	
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
	--with-mcrypt \
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
	&& make \
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
	&& ln -s /usr/local/php/bin/php-config /usr/bin/php-config

RUN wget https://openresty.org/download/openresty-1.11.2.5.tar.gz -O openresty-1.11.2.5.tar.gz
RUN tar -xzvf openresty-1.11.2.5.tar.gz \
	&& cd openresty-1.11.2.5 \
	&& ./configure -j2 --prefix=/usr/local/openresty-1.11.2.5 \
	&& make -j2 \
	&& make install
ADD ./etc/openresty/nginx.conf /usr/local/openresty-1.11.2.5/nginx/conf/nginx.conf
RUN ln -s /usr/local/openresty-1.11.2.5 /usr/local/openresty

RUN wget http://download.redis.io/releases/redis-3.2.11.tar.gz -O redis-3.2.11.tar.gz
RUN tar -xzvf redis-3.2.11.tar.gz \
	&& cd redis-3.2.11 \
	&& make \
	&& make PREFIX=/usr/local/redis-3.2.11 install \
	&& mkdir /usr/local/redis-3.2.11/etc/
ADD ./etc/redis/redis.conf 	/usr/local/redis-3.2.11/etc/redis.conf
RUN ln -s /usr/local/redis-3.2.11 /usr/local/redis

RUN groupadd www \
	&& useradd -s /sbin/nologin -g www www \
	&& mkdir -p /data/www \
	&& chown www:www /data/www -R

WORKDIR /root/
EXPOSE 80
ADD ./etc/run.sh ./
RUN chmod +x run.sh
CMD /root/run.sh && /bin/bash