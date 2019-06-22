#!/bin/bash

# Created and tested on ubuntu 16.04 xenial

# Add key, repo, install amd start docker
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
apt-get update
apt-get install -y docker-engine
systemctl enable docker
systemctl start docker
usermod -aG docker ubuntu

# run jenkins
mkdir -p /var/jenkins_home
chown -R 1000:1000 /var/jenkins_home/
docker run -p 8080:8080 -p 50000:50000 -v /var/jenkins_home:/var/jenkins_home -d --name jenkins jenkins/jenkins:lts

#curl check
if ! [ "$(command -v curl)" ]; then
	echo "Error: curl is not installed."
	apt-get install -y curl
fi

# show endpoint
echo 'Jenkins installed'
echo 'You should now be able to access jenkins at: http://'$(curl -s ifconfig.co)':8080'
