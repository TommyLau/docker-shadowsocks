FROM alpine:3.7

MAINTAINER Tommy Lau <tommy@gen-new.com>

RUN buildDeps=" \
		asciidoc \
		build-base \
		c-ares-dev \
		curl \
		libev-dev \
		libsodium-dev \
		linux-headers \
		mbedtls-dev \
		pcre-dev \
		tar \
		xmlto \
	"; \
	set -x \
	&& apk add --update --virtual .build-deps $buildDeps \
	&& SS_VERSION=`curl "https://github.com/shadowsocks/shadowsocks-libev/releases/latest" | sed -n 's/^.*tag\/v\(.*\)".*/\1/p'` \
	&& curl -SL "https://github.com/shadowsocks/shadowsocks-libev/releases/download/v$SS_VERSION/shadowsocks-libev-$SS_VERSION.tar.gz" -o ss.tar.gz \
	&& mkdir -p /usr/src/ss \
	&& tar -xf ss.tar.gz -C /usr/src/ss --strip-components=1 \
	&& rm ss.tar.gz \
	&& cd /usr/src/ss \
	&& ./configure --disable-documentation \
	&& make install \
	&& cd / \
	&& rm -fr /usr/src/ss \
	&& runDeps="$( \
		scanelf --needed --nobanner /usr/local/bin/ss-* \
			| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
			| xargs -r apk info --installed \
			| sort -u \
		)" \
	&& apk add --virtual .run-deps $runDeps \
	&& apk del .build-deps \
	&& rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/local/bin/ss-server"]
