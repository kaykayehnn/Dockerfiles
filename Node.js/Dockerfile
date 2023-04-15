# For smaller images you can use 18-alpine
FROM node:18 as tini-env

# Add Tini
ENV TINI_VERSION v0.19.0
RUN wget -q -O - https://raw.githubusercontent.com/kaykayehnn/Dockerfiles/main/common/download-tini.sh | sh

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
