apt update;
apt install git;

# Jenkins
apt-get install openjdk-8-jdk;
wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | apt-key add;
echo "deb http://pkg.jenkins-ci.org/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list;
apt update;
apt install jenkins;

# Docker
apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common;
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -;
apt-key fingerprint 0EBFCD88;
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable";
apt-get update;
apt-get install docker-ce;