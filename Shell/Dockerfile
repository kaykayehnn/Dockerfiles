# syntax=docker/dockerfile:1
FROM alpine:3.17 AS build-env

# Add Tini
ENV TINI_VERSION v0.19.0
RUN wget -q -O - https://raw.githubusercontent.com/kaykayehnn/Dockerfiles/main/common/download-tini.sh | sh

WORKDIR /app

# Build runtime image
FROM alpine:3.17

# Setup Tini
COPY --from=build-env /tini /
ENTRYPOINT ["/tini", "--"]

WORKDIR /app

# Copy app files
COPY script.sh .

CMD [ "/app/script.sh" ]
