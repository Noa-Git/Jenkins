FROM openjdk:8-jre-slim
RUN mkdir web
COPY target/demo.jar web/demo.jar
WORKDIR web
CMD java -jar demo.jar

FROM jenkins/jenkins:lts
USER root
RUN apt-get update && apt-get install -y maven
