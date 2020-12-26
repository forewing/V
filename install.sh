#!/bin/sh

# bash <(curl -s https://raw.githubusercontent.com/forewing/V/main/install.sh)

if ! command -v docker &> /dev/null
then
    echo "docker not found, install"
    bash <(curl -s https://get.docker.com)
fi

if ! command -v docker-compose &> /dev/null
then
    echo "docker-compose not found, install"
    curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

if [ -z "${TARGET_PATH}" ]; then
    TARGET_PATH="/app/v"
fi

mkdir -p $TARGET_PATH

curl -fsSL https://raw.githubusercontent.com/forewing/V/main/docker-compose.yml -o $TARGET_PATH/docker-compose.yml
curl -fsSL https://raw.githubusercontent.com/forewing/V/main/example.env -o $TARGET_PATH/.env

cd $TARGET_PATH
docker-compose pull
