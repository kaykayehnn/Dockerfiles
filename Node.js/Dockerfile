# For smaller images you can use 18-alpine
FROM node:18 as tini-env

# Add Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN gpg --batch --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
  && gpg --batch --verify /tini.asc /tini \
  && chmod +x /tini

FROM node:18

# Setup Tini
COPY --from=tini-env /tini /
ENTRYPOINT ["/tini", "--"]

ENV NODE_ENV=production

WORKDIR /usr/src/myapp
COPY . /usr/src/myapp

RUN npm install

USER node
CMD ["node", "index.js"]
