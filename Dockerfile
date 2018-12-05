FROM alpine:latest

USER root

RUN \
  apk update && \
  apk upgrade && \
  apk add openjdk8 && \
  rm -rf /var/cache/apk/*

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
COPY ./target/*.jar /tmp
WORKDIR /tmp
CMD ["java", "-cp", "target/my-app-1.0-SNAPSHOT.jar", "com.mycompany.app.App"]
