job('NodeJS Docker example') {
    scm {
        git('https://github.com/patnowy/docker-demo') {  node -> // is hudson.plugins.git.GitSCM
            node / gitConfigName('DSL User')
            node / gitConfigEmail('jenkins-dsl@jenkins.localhost')
        }
    }
    triggers {
        scm('H/5 * * * *')
    }
    wrappers {
        nodejs('nodejs') // this is the name of the NodeJS installation in 
                         // Manage Jenkins -> Configure Tools -> NodeJS Installations -> Name
    }
    steps {
        dockerBuildAndPublish {
            repositoryName('patnowy/nodejs-demo')
            tag('${GIT_REVISION,length=9}') // tag with git sha
            registryCredentials('dockerhub')
            forcePull(false) // https://jenkinsci.github.io/job-dsl-plugin/
            forceTag(false)
            createFingerprints(false)
            skipDecorate()
        }
    }
}
