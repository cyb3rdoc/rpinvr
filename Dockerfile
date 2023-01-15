FROM node:alpine

RUN apk update \
  && apk add --no-cache \
  ffmpeg \
  && rm -rf /var/cache/apk/*

#RUN ln -s /usr/local/bin /usr/local/sbin

# Create app directory
WORKDIR /app

# Install app dependencies
COPY ./app/package*.json ./

RUN npm install \
  && npm install -g pm2 \
  && npm prune --omit=dev

# Bundle app source
COPY ./app/ ./

VOLUME ["/app/config", "/app/storage"]

EXPOSE 3000 3001

ENTRYPOINT ["pm2", "--no-daemon", "start"]

CMD ["nvr.js", "nvr-browser.js"]
