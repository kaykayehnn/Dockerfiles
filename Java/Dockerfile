FROM openjdk:11 as tini-env

# Add Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN gpg --batch --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
  && gpg --batch --verify /tini.asc /tini \
  && chmod +x /tini

FROM openjdk:11

# Setup Tini
COPY --from=tini-env /tini /
ENTRYPOINT ["/tini", "--"]

WORKDIR /usr/src/myapp
COPY . /usr/src/myapp

RUN javac Main.java

CMD ["java", "Main"]
