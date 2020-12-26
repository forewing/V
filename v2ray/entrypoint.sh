#!/bin/sh

TARGET_CONFIG="/etc/v2ray/config.json"

if [ -z "${V_PATH}" ]; then
    echo "please provide V_PATH environment variable"
    exit 1
fi

if [ -z "${V_UUID}" ]; then
    V_UUID=`cat /proc/sys/kernel/random/uuid`
    echo "use generated uuid $V_UUID"
else
    echo "use uuid from V_UUID"
fi

cat <<EOF > $TARGET_CONFIG
{
  "inbounds": [
    {
      "port": 35608,
      "listen":"0.0.0.0",
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "$V_UUID",
            "alterId": 64
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
        "path": "$V_PATH"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}
EOF

/usr/bin/v2ray -config $TARGET_CONFIG
