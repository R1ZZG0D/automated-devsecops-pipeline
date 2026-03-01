**Prerequisite: Create 3 EC2 servers** 



 - Build server with 20 GB storage - t2.medium
 - Sonarqube server with 4 GB memory - t2.medium
 - Jenkins server - t2.medium


**Step 1: Ensure all the necessary plugins are installed in Jenkins Server**:



 - Parameterized trigger plugin

 - Gitlab plugin

 - Docker Pipeline

 - Pipeline: AWS steps

 - SonarQube Scanner

 - Sonar Quality Gates

**Step 2: Install Docker, Java8, Java11 & Trivy on Build Server using the setup.sh file**

```shell
$ sudo ./setup.sh
```

**Step 3: Install Sonrqube on the t2.medium server**

```shell
$ sudo apt update
$ sudo apt install -y docker.io
$ sudo usermod -a -G docker ubuntu
$ sudo docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
```

**Step 4: Add necessary credentials**



- Generate Sonarqube token of type "global analysis token" and add it as Jenkins credential of type "secret text"

- Add dockerhub credentials as username/password type

- Add Gitlab credentials as username/password type

- Add Build server credentials for Jenkins server to connect


**Step 5: Enable Sonarqube webhook for Sonar Quality Gates & Install dependency-check plugin**




- Generate webhook & add the Jenkins URL as follows : http://URL:8080/sonarqube-webhook/