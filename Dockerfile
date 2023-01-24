FROM node:latest

RUN set -ex \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  ffmpeg \
  && apt-get clean \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

WORKDIR /app

COPY ./app/package*.json ./

RUN npm install \
  && npm install -g pm2 \
  && npm prune --omit=dev

COPY ./app/ ./

VOLUME ["/app/config", "/app/storage"]

EXPOSE 3000 3001

ENTRYPOINT ["pm2", "--no-daemon", "start"]

CMD ["nvr.js", "nvr-browser.js"]
