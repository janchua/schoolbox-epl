FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get update && \
  apt-get install -y \
    nodejs \
    npm \
    abiword \
    curl \
    && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/*
RUN \
  curl -L https://github.com/ether/etherpad-lite/archive/1.6.6.tar.gz --output 1.6.6.tar.gz && \
  tar xzf 1.6.6.tar.gz && \
  rm -vf 1.6.6.tar.gz && \
  mv etherpad-lite-1.6.6 /usr/share/schoolbox-epl && \
  cd /usr/share/schoolbox-epl/src && \
  npm install && \
  npm install redis && \
  npm install ep_disableChat && \
  npm install ep_disable_change_author_name && \
  npm install ep_headings && \
  cd /usr/share/schoolbox-epl && \
  bin/installDeps.sh && \
  mkdir -vp /etc/schoolbox-epl && \
  rm -vf /usr/share/schoolbox-epl/settings.json && \
  rm -vf /usr/share/schoolbox-epl/APIKEY.txt && \
  ln -sv /etc/schoolbox-epl/settings.json /usr/share/schoolbox-epl/ && \
  ln -sv /etc/schoolbox-epl/APIKEY.txt /usr/share/schoolbox-epl/
WORKDIR /usr/share/schoolbox-epl
CMD node src/node/server.js
EXPOSE 9001
