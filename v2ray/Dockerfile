FROM v2fly/v2fly-core:latest

RUN apk add --no-cache dumb-init

WORKDIR /app
ADD entrypoint.sh /app

ENTRYPOINT ["dumb-init", "--", "sh", "/app/entrypoint.sh"]
