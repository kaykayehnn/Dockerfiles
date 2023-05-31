# If you have any issues with Alpine's native libraries, you can switch to the
# debian-based image.
FROM node:18-alpine as tini-env

# Add Tini
ENV TINI_VERSION v0.19.0
RUN wget -q -O - https://raw.githubusercontent.com/kaykayehnn/Dockerfiles/main/common/download-tini.sh | sh

# Compile TypeScript
FROM node:18-alpine as build-env

WORKDIR /usr/src/myapp
COPY . /usr/src/myapp

RUN npm install && npm run build && rm -rf node_modules/

# Final image
FROM node:18-alpine

# Setup Tini
COPY --from=tini-env /tini /
ENTRYPOINT ["/tini", "--"]

ENV NODE_ENV=production

COPY --from=build-env /usr/src/myapp /
WORKDIR /usr/src/myapp

RUN npm

USER node
CMD ["node", "dist/index.js"]
