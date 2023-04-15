FROM openjdk:11 as tini-env

# Add Tini
ENV TINI_VERSION v0.19.0
RUN wget -q -O - https://raw.githubusercontent.com/kaykayehnn/Dockerfiles/main/common/download-tini.sh?21 | sh

FROM openjdk:11

# Setup Tini
COPY --from=tini-env /tini /
ENTRYPOINT ["/tini", "--"]

WORKDIR /usr/src/myapp
COPY . /usr/src/myapp

RUN javac Main.java

CMD ["java", "Main"]
