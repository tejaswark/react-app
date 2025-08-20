#!/bin/bash

# Define the root directory
ROOT_DIR="my-react-app"

# Create the main directory and subdirectories
mkdir -p $ROOT_DIR/public
mkdir -p $ROOT_DIR/src
mkdir -p $ROOT_DIR/build

# Create some essential files
touch $ROOT_DIR/package.json
touch $ROOT_DIR/Jenkinsfile

# Optional: You can add any default content to these files if necessary
echo '{
  "name": "my-react-app",
  "version": "1.0.0",
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  },
  "dependencies": {}
}' > $ROOT_DIR/package.json

echo 'pipeline {
    agent any

    environment {
        NODE_HOME = "/usr/local/bin"
        PATH = "$NODE_HOME:$PATH"
    }

    stages {
        stage("Checkout") {
            steps {
                git "https://github.com/tejaswark/react-app.git"
            }
        }
        
        stage("Install Dependencies") {
            steps {
                sh "npm install"
            }
        }
        
        stage("Build") {
            steps {
                sh "npm run build"
            }
        }
        
        stage("Deploy") {
            steps {
                sh "scp -r build/* user@your-server.com:/var/www/html/"
            }
        }
    }
    
    post {
        success {
            echo "Deployment successful!"
        }
        
        failure {
            echo "Deployment failed."
        }
    }
}' > $ROOT_DIR/Jenkinsfile

echo "Directory structure created successfully!"

