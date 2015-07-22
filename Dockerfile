FROM node:latest

RUN \
   apt-get update --fix-missing && \
   apt-get install -y git vim  && \
   apt-get clean -y && \
   apt-get autoclean -y && \
   apt-get autoremove -y && \
   rm -rf /tmp/* && \
   rm -rf /var/lib/{apt,dpkg,cache,log,tmp}/*

RUN git clone https://github.com/AndrewBelt/hack.chat.git
RUN cd hack.chat && npm install
RUN cd hack.chat && cp config-sample.json config.json
RUN npm install -g less jade http-server forever
RUN cd hack.chat/client && make

EXPOSE 80 6060

CMD cd hack.chat && forever start server.js && cd client && http-server -p 80
