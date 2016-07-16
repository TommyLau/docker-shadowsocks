FROM alpine:3.4

MAINTAINER Tommy Lau <tommy@gen-new.com>

RUN buildDeps=" \
		build-base \
		curl \
		linux-headers \
		openssl-dev \
		tar \
	"; \
	set -x \
	&& apk add --update openssl \
	&& apk add $buildDeps \
	&& SS_VERSION=`curl "https://github.com/shadowsocks/shadowsocks-libev/releases/latest" | sed -n 's/^.*tag\/\(.*\)".*/\1/p'` \
	&& curl -SL "https://github.com/shadowsocks/shadowsocks-libev/archive/$SS_VERSION.tar.gz" -o ss.tar.gz \
	&& mkdir -p /usr/src/ss \
	&& tar -xf ss.tar.gz -C /usr/src/ss --strip-components=1 \
	&& rm ss.tar.gz \
	&& cd /usr/src/ss \
	&& ./configure \
	&& make install \
	&& cd / \
	&& rm -fr /usr/src/ss \
	&& apk del $buildDeps \
	&& rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/local/bin/ss-server"]
