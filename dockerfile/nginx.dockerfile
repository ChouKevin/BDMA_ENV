FROM ubuntu:16.04

RUN apt-get update -y \
&&  apt-get install openssl libperl-dev libgeoip-dev libgd-dev wget git libpcre3 libpcre3-dev libssl-dev libxslt-dev -y

RUN wget https://nginx.org/download/nginx-1.19.0.tar.gz
RUN tar zxf nginx-1.19.0.tar.gz
RUN git clone git://github.com/yaoweibin/ngx_http_substitutions_filter_module.git

WORKDIR /nginx-1.19.0
RUN ./configure --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --modules-path=/usr/lib/nginx/modules --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-debug --with-pcre-jit --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_v2_module --with-http_dav_module --with-http_slice_module --with-threads --with-http_addition_module --with-http_flv_module --with-http_geoip_module=dynamic --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module=dynamic --with-http_mp4_module --with-http_perl_module=dynamic --with-http_random_index_module --with-http_secure_link_module --with-http_sub_module --with-http_xslt_module=dynamic --with-mail=dynamic --with-mail_ssl_module --with-stream=dynamic --with-stream_ssl_module --with-stream_ssl_preread_module --add-module=../ngx_http_substitutions_filter_module
RUN make && make install
COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /var/lib/nginx/{body,fastcgi}
WORKDIR /etc/nginx
# jupyter port
EXPOSE 18888
# spark master port
EXPOSE 18080
# spark worker port
EXPOSE 18081 
EXPOSE 18082

RUN openssl req -x509 -nodes -subj "/C=US/ST=CA/L=SF/O=Docker-demo/CN=app.example.org" \ 
                -days 3650 -newkey rsa:2048 -keyout mykey.key -out mycert.pem

CMD ["nginx", "-g", "daemon off;"]