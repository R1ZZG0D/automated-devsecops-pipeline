pipeline {
  agent { label 'build' }

  environment {
        registry = "r1zzg0d/devsecops-pipeline"
        registryCredential = 'dockerhub'
  }

  stages {

    stage('Checkout') {
      steps {
        git branch: 'main',
        credentialsId: 'GitlabCred',
        url: 'https://gitlab.com/r1zzg0d-projects/automated-devsecops-pipeline/devsecops-build-pipeline.git'
      }
    }

    stage('Stage I: Build') {
      steps {
        echo "Building Jar Component ..."
        sh "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64; mvn clean package"
      }
    }

    stage('Stage II: Code Coverage') {
      steps {
        echo "Running Code Coverage ..."
        sh "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64; mvn jacoco:report"
      }
    }

    stage('Stage III: SCA') {
      steps {
        echo "Running Software Composition Analysis using OWASP Dependency-Check ..."
        withCredentials([string(credentialsId: 'nvd-api-key', variable: 'NVD_API_KEY')]) {
          sh "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64; export PATH=\$JAVA_HOME/bin:\$PATH; mvn org.owasp:dependency-check-maven:12.1.0:check -DnvdApiKey=${NVD_API_KEY} -DossindexAnalyzerEnabled=false"
        }
        
      }
    }

    stage('Stage IV: SAST') {
      steps {
        echo "Running Static application security testing using SonarQube Scanner ..."
         withSonarQubeEnv('sonar') {
          sh 'mvn sonar:sonar -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml -Dsonar.dependencyCheck.jsonReportPath=target/dependency-check-report.json -Dsonar.dependencyCheck.htmlReportPath=target/dependency-check-report.html -Dsonar.projectName=wezvatech'
        }
      }
    }

    stage('Stage V: QualityGates') {
      steps {
        echo "Running Quality Gates to verify the code quality"
        script {
          timeout(time: 5, unit: 'MINUTES') {
            def qg = waitForQualityGate()
            if (qg.status != 'OK') {
              error "Pipeline aborted due to quality gate failure: ${qg.status}"
            }
           }
        }
      }
    }

    stage('Stage VI: Build Image') {
      steps {
        echo "Building Docker Image"
        script {
          docker.withRegistry('', registryCredential) {
            myImage = docker.build(registry)
            myImage.push()
          }
        }
      }
    }

    stage('Stage VII: Scan Image') {
      steps {
        echo "Scanning Image for Vulnerabilities"
        sh "trivy image --scanners vuln --offline-scan ${registry}:latest > trivyresults.txt"
      }
    }

    stage('Stage VIII: Smoke Test') {
      steps {
        echo "Running Smoke Test"
        sh "docker run -d --name smokerun -p 8080:8080 ${registry}"
        sh "sleep 90; ./check.sh"
        sh "docker rm --force smokerun"
      }
    }
  }
}