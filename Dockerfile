FROM node:8.12-alpine

WORKDIR /usr/local/app

# Installs latest Chromium package.
RUN apk update && apk upgrade && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    apk add --no-cache \
      chromium@edge \
      nss@edge

# Install Japanese font
# https://qiita.com/nju33/items/b80d92a4257edeb4b9a1
RUN apk update && \
    apk add --no-cache curl fontconfig && \
    curl -O https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip && \
    mkdir -p /usr/share/fonts/NotoSansCJKjp && \
    unzip NotoSansCJKjp-hinted.zip -d /usr/share/fonts/NotoSansCJKjp/ && \
    rm NotoSansCJKjp-hinted.zip && \
    fc-cache -fv

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# Add user so we don't need --no-sandbox.
RUN addgroup -S pptruser && adduser -S -g pptruser pptruser \
    && mkdir -p /home/pptruser/Downloads \
    && chown -R pptruser:pptruser /home/pptruser \
    && chown -R pptruser:pptruser /usr/local/app

# Run everything after as non-privileged user.
USER pptruser

COPY . /usr/local/app

RUN npm install

CMD [ "npm", "start" ]
