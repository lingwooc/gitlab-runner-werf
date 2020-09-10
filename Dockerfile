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