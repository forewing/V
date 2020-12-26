#!/bin/sh

TARGET_CADDYFILE="/etc/caddy/Caddyfile.V"

if [ -z "${V_DOMAIN}" ]; then
    echo "please provide V_DOMAIN environment variable"
    exit 1
fi

if [ -z "${V_PATH}" ]; then
    echo "please provide V_PATH environment variable"
    exit 1
fi

if [ -z "${CLOUDFLARE_API_TOKEN}" ]; then
    echo "using HTTP challenge, make sure $V_DOMAIN point to the server and port 80 is open"
else
    echo "using token from CLOUDFLARE_API_TOKEN for cloudflare DNS challenge"
    DNS_CONFIG="dns cloudflare {env.CLOUDFLARE_API_TOKEN}"
fi

cat <<EOF > $TARGET_CADDYFILE
$V_DOMAIN {
    tls {
        protocols tls1.2 tls1.3
        $DNS_CONFIG
    }
    root * /usr/share/caddy
    file_server
    @v_websocket {
        path $V_PATH
        header Connection *Upgrade*
        header Upgrade websocket
    }
    reverse_proxy @v_websocket v2ray:35608
}
EOF

/usr/bin/caddy run --config $TARGET_CADDYFILE --adapter caddyfile
