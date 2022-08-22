ROM node:alpine

RUN apk update \
  && apk upgrade \
  && apk add --no-cache \
  ffmpeg \
  && rm -rf /var/cache/apk/*

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY ./app/package*.json ./

RUN npm install \
  && npm audit fix \
  && npm install -g pm2
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY ./app/ ./

VOLUME ["/usr/src/app/config", "/storage"]

EXPOSE 3000 3001

ENTRYPOINT ["pm2", "--no-daemon", "start"]

CMD ["nvr.js", "nvr-browser.js"]
