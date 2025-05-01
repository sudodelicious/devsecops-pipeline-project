pipeline {
  agent any

  environment {
    PROJECT_DIR = 'app'         // Change if needed
    INFRA_DIR = 'ansible'       // Ansible path
    SCRIPTS_DIR = 'scripts'     // Security script path
  }

  stages {
    stage('Checkout') {
      steps {
        git credentialsId: 'your-git-creds-id', url: 'https://github.com/your-org/Pipeline-Project.git'
      }
    }

    stage('Scan: Trivy (App Folder)') {
      steps {
        dir("${PROJECT_DIR}") {
          bat "powershell ../${SCRIPTS_DIR}/trivy.ps1"
        }
      }
    }

    stage('Scan: Checkov (Ansible)') {
      steps {
        dir("${INFRA_DIR}") {
          bat "powershell ../${SCRIPTS_DIR}/checkov-ansible.ps1"
        }
      }
    }

    stage('Scan: Gitleaks (Secrets Check)') {
      steps {
        dir("${PROJECT_DIR}") {
          bat "powershell ../${SCRIPTS_DIR}/gitleaks.ps1"
        }
      }
    }

    stage('Archive Reports') {
      steps {
        archiveArtifacts artifacts: '**/trivy-results.txt, **/checkov-results.txt, **/gitleaks-results.txt', onlyIfSuccessful: true
      }
    }
  }

  post {
    always {
      echo "🛡️ Security scan completed."
    }
    failure {
      mail to: 'security-team@yourcompany.com',
           subject: "❌ Security Scan Failed - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
           body: "Check scan results and logs in Jenkins for more details."
    }
  }
}
