FROM ttbb/compile:c AS openresty

LABEL maintainer="shoothzj@gmail.com"

WORKDIR /opt/sh

RUN wget https://openresty.org/download/openresty-1.19.9.1.tar.gz && \
mkdir /opt/sh/aux && \
tar -xf /opt/sh/openresty-1.19.9.1.tar.gz -C /opt/sh/aux --strip-components 1 && \
rm -rf /opt/sh/openresty-1.19.9.1.tar.gz && \
cd /opt/sh/aux && \
dnf install -y perl pcre-devel openssl-devel zlib-devel && \
mkdir /opt/sh/openresty && \
./configure --prefix=/opt/sh/openresty && \
gmake && \
gmake install

WORKDIR /opt/sh/openresty

FROM ttbb/base

COPY --from=openresty /opt/sh/openresty /opt/sh/openresty

RUN ln -s /opt/sh/openresty/nginx/sbin/nginx /usr/bin/nginx && \
ln -s /opt/sh/openresty/bin/openresty /usr/bin/openresty && \
ln -s /opt/sh/openresty/bin/resty /usr/bin/resty

WORKDIR /opt/sh/openresty