Jenkins
pipeline {
  agent any

  stages {
    stage('Pull from GitHub') {
      steps {
        git 'https://github.com/<your-github-username>/<your-repo>.git'
      }
    }

    stage('Build and Test') {
      steps {
        dir('UmbracoApp') {
          // Restore NuGet packages
          sh 'dotnet restore'

          // Build the Umbraco solution
          sh 'dotnet build -c Release'

          // Publish the Umbraco application
          sh 'dotnet publish -c Release -o ./publish'
        }
      }
    }

    stage('Containerize') {
      steps {
        dir('UmbracoApp') {
          // Build the Docker image
          sh 'docker build -t umbraco-app:latest .'
        }
      }
    }

    stage('Deploy to Test Environment') {
      environment {
        // Set environment-specific variables here
        environmentVariableTest = "test-value"
      }
      steps {
        // Deploy to your test environment
        sh 'deploy-to-test.sh'
      }
    }

    stage('Deploy to Production Environment') {
      environment {
        // Set environment-specific variables here
        environmentVariableProd = "prod-value"
      }
      steps {
        // Deploy to your production environment
        sh 'deploy-to-production.sh'
      }
    }
  }

  post {
    success {
      // Send success notification
      sendNotification("Deployment Successful")
    }

    failure {
      // Send failure notification
      sendNotification("Deployment Failed")
    }
  }
}

def sendNotification(String message) {
  // Send email notification
  emailext body: "${Deployment Successful}", subject: "${Jenkins}", to: "dolapofashina@gmail.com"

  // Send Slack notification
  slackSend(color: 'good', message: "${Deployment Successful}", tokenCredentialId: 'slack-token')
}
