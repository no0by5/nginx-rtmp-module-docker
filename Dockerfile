FROM debian:10
# FROM alpine:3

RUN apt-get update && apt-get install -y git build-essential libpcre3-dev libssl-dev zlib1g-dev

RUN mkdir /app \
 && cd /app \
 && git clone https://github.com/sergey-dryabzhinsky/nginx-rtmp-module \
 && git clone https://github.com/nginx/nginx.git \
 && cd nginx \
 && ./auto/configure --with-http_ssl_module --add-module=../nginx-rtmp-module \
 && make \
 && make install

COPY nginx.conf /usr/local/nginx/conf/nginx.conf

ENTRYPOINT ["/usr/local/gninx/sbin/nginx"]
CMD ["-g", "daemon off;"]
