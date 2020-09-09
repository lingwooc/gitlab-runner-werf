FROM gitlab/gitlab-runner

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

#RUN usermod -aG docker gitlab-runner

USER gitlab-runner

# add ~/bin into PATH
RUN export PATH=$PATH:$HOME/bin &&\
    echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc &&\
    mkdir -p ~/bin &&\
    cd ~/bin &&\
    curl -L https://raw.githubusercontent.com/werf/multiwerf/master/get.sh | bash

RUN mkdir -p /home/gitlab-runner/.kube &&\
    chown -R gitlab-runner:gitlab-runner /home/gitlab-runner/.kube

USER root