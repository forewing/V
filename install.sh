#!/bin/sh

# bash <(curl -s https://raw.githubusercontent.com/forewing/V/main/install.sh)

curl -fsSL https://get.docker.com -o /tmp/get-docker.sh

sh /tmp/get-docker.sh

curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

if [ -z "${TARGET_PATH}" ]; then
    TARGET_PATH="/app/v"
fi

mkdir -p $TARGET_PATH

curl -fsSL https://raw.githubusercontent.com/forewing/V/main/docker-compose.yml -o $TARGET_PATH/docker-compose.yml
curl -fsSL https://raw.githubusercontent.com/forewing/V/main/example.env -o $TARGET_PATH/.env

cd $TARGET_PATH
docker-compose pull
