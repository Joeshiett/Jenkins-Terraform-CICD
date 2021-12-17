#!/usr/bin/env groovy

pipeline {
    agent any
    
    stages {
        
        stage('Provision Server') {
            environment {
                AWS_ACCESS_KEY_ID = credentials('aws_access_key_id')
                AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
                TF_VAR_env_prefix = 'test'
            }
            steps {
                script {
                    dir('terraform') {
                        sh "terraform init"
                        sh "terraform apply --auto-approve"
                        EC2_PUBLIC_IP = sh(
                            script: "terraform output ec2_public_ip",
                            returnStdout: true
                        ).trim()
                    }
                }
            }
        }
        stage('Deploy WordPress to Dev') {
            environment {
                DOCKER_CREDS = credentials('dockerhub_id')
            }
            steps {
                script {
                   echo "waiting for EC2 to initialize" 
                   sleep(time: 120, unit: "SECONDS") 

                   echo 'deploying WordPress to Dev...'
                   echo "${EC2_PUBLIC_IP}"

                   def shellCmd = "bash ./server-cmds.sh ${DOCKER_CREDS_USR} ${DOCKER_CREDS_PSW}"
                   def ec2Instance = "ubuntu@${EC2_PUBLIC_IP}"

                   sshagent(['server-ssh-key']) {
                       sh "scp -o StrictHostKeyChecking=no server-cmds.sh ${ec2Instance}:/home/ubuntu"
                       sh "scp -o StrictHostKeyChecking=no docker-compose.yml ${ec2Instance}:/home/ubuntu"
                       sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} ${shellCmd}"
                   }
                }
            }
        }
    }
}
