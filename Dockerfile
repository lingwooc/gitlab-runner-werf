FROM gitlab/gitlab-runner:latest

RUN apt-get update &&\
    apt install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common &&\
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - &&\
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable" &&\
    apt-get install docker-ce-cli

RUN cd /usr/bin &&\
    curl -L https://raw.githubusercontent.com/werf/multiwerf/master/get.sh | bash

RUN groupadd -g 998 docker &&\
    usermod -aG docker gitlab-runner

RUN curl -L https://gitlab-docker-machine-downloads.s3.amazonaws.com/v0.16.2-gitlab.5/docker-machine >/tmp/docker-machine &&\
  mv /tmp/docker-machine /usr/local/bin/docker-machine &&\
  chmod +x /usr/local/bin/docker-machine &&\
  wget https://github.com/JonasProgrammer/docker-machine-driver-hetzner/releases/download/2.1.0/docker-machine-driver-hetzner_2.1.0_linux_amd64.tar.gz &&\
  tar -xvf docker-machine-driver-hetzner_2.1.0_linux_amd64.tar.gz &&\
  chmod +x docker-machine-driver-hetzner &&\
  rm docker-machine-driver-hetzner_2.1.0_linux_amd64.tar.gz &&\
  mv docker-machine-driver-hetzner /usr/local/bin/