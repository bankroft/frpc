FROM --platform=linux/arm64 alpine:latest

ARG VERSION=0.34.3
ARG PLATFORM=linux_arm64

RUN apk add --no-cache wget

ARG _FRP_URI=https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_${PLATFORM}.tar.gz

WORKDIR /frpc

RUN wget -O frp.tar.gz -q ${_FRP_URI} \
    && tar -zxf frp.tar.gz -C . --strip-components 1 \
    && rm -rf frp.tar.gz && rm -rf frps* && rm -rf systemd \
    && chmod +x ./frpc \
    && echo -e '#!/bin/sh\n/frpc/frpc -c /frpc/frpc.ini' > /start.sh && chmod +x /start.sh

VOLUME /frpc

CMD ["/start.sh"]
