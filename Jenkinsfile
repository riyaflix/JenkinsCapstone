pipeline
{
    agent any
    
    tools 
    { 
        maven 'maven' 
        jdk 'jdk11' 
    }
    options 
    {
    buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    stages
    {
        stage("cleaning")
        {
            steps
            {
                sh "mvn clean"
            }
        }
        stage("compile")
        {
            when
            {
                branch 'dev'
            }
            steps
            {
                sh "mvn compile"
            }
        }
        stage("testing")
        {
            steps
            {
                //sh "mvn test"
                sh 'echo "Listing the files in the current dir"'
                sh "ls"
            }
        }
        stage("packaging")
        {
            when
            {
                expression { BRANCH_NAME ==~ /(development|production)/ }
            }
            steps
            {
                sh 'mvn package'
            }
        }
        stage("deploying")
        {
            when
            {
                branch 'production'
            }
            steps{
                
                sh './deploy.sh'
            }
        }

    }
    post
    {
        always
        {
            emailext body:  '''$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS: Check console output and logs at -> $BUILD_URL ''',
            subject: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!',
            to: 'riya@knoldus.com'
        }
        success
        {
            echo "========pipeline executed successfully ========"
        }
        failure
        {
            echo "========pipeline execution failed========"
        }
    }
}
