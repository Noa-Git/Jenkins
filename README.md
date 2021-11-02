# Jenkins

This project demonstrate usage of Jenkins Master in Docker.
Project deploys snapshot and release of `serving-web-content` application and upload it to the deployment server

#### Pre-requisites
* IPs
* Private key
* Machine AMI
* Machine has docker installed

#### Install
```bash 
    scp -r -i .\Jenkins-Master\<jkey> .\remote ec2-user@34.255.87.58: 
    ssh -i .\Jenkins-Master\<jkey> ec2-user@34.255.87.58
```

##### Install jenkins master image and plugins on jenkins server
```bash 
    cd remote
    docker-compose up -d 
    docker-compose exec jenkins bash var/jenkins_config/apply_config.sh
```
 
##### Install docker inside jenkins container
```bash 
    docker-compose exec jenkins apt-get update && apt-get install -y lsb-release
    docker-compose exec jenkins curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
      https://download.docker.com/linux/debian/gpg
    docker-compose exec echo "deb [arch=$(dpkg --print-architecture) \
      signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
      https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
    docker-compose exec apt-get update && apt-get install -y docker-ce-cli
```

##### Post-installation Tasks
Configure Jenkins Pipeline:
1. Go to http://34.255.87.58:8081
2. Sign in with user/admin using:
    ```docker-compose exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword```
3. Create multibranch pipeline
4. Configure subversion (installed plugin) branch sources
5. Setup GH webhook (followed by [this](https://www.blazemeter.com/blog/how-to-integrate-your-github-repository-to-your-jenkins-project) guide)
6. Setup SMTP (mailer plugin installed)
7. Build the job manually or push to [this](https://github.com/Noa-Git/Jenkins.git) repo

###### Successful build-expected
Maven release deployed in `deployment` server

#### TODO:
- [ ] Use [CASC](https://github.com/jenkinsci/configuration-as-code-plugin) instead of manual configuration in the UI.
- [ ] Combine the jenkins and web server into a single docker-compose file
- [ ] Complete expected build outcome
