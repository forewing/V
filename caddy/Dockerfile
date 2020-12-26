FROM caddy:2.2.1-builder AS builder

RUN go env -w GO111MODULE=on && \
    go env -w GOPROXY=https://goproxy.io,direct && \
    xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2.2.1

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN apk add --no-cache dumb-init

WORKDIR /app
ADD entrypoint.sh /app

ENTRYPOINT ["dumb-init", "--", "sh", "/app/entrypoint.sh"]
