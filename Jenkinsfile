pipeline {
    agent any

    parameters {
        choice(
            name: 'ENV',
            choices: ['dev', 'stage', 'prod'],
            description: 'Select environment'
        )

        choice(
            name: 'ACTION',
            choices: ['plan', 'apply', 'destroy'],
            description: 'Terraform action'
        )

        choice(
            name: 'AWS_REGION',
            choices: ['us-east-1', 'ap-south-1'],
            description: 'AWS Region'
        )
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        AWS_DEFAULT_REGION    = "${params.AWS_REGION}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            when {
                expression { params.ACTION == 'plan' }
            }
            steps {
                sh "terraform plan -var='env=${params.ENV}'"
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            input {
                message "Apply Terraform for ${params.ENV}?"
            }
            steps {
                sh "terraform apply -auto-approve -var='env=${params.ENV}'"
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            input {
                message "DESTROY Terraform for ${params.ENV}?"
            }
            steps {
                sh "terraform destroy -auto-approve -var='env=${params.ENV}'"
            }
        }
    }
}
