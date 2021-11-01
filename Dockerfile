FROM jenkins/jenkins:2.303.2-jdk11
USER root
RUN apt-get update && apt-get install -y apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins

# make sure plugins are installed
COPY var/jenkins_config/plugins.txt /var/jenkins_home
#RUN usr/local/bin/install-plugins.sh < var/jenkins_home/plugins.txt
RUN jenkins-plugin-cli -f /var/jenkins_home/plugins.txt || echo "Plugins download failed!"
