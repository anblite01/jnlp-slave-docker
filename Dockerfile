FROM jenkinsci/jnlp-slave:2.52

USER root

# Install Docker v1.11.2
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates software-properties-common && \
    curl -fsSL https://yum.dockerproject.org/gpg|apt-key add - && \
    apt-key fingerprint 58118E89F3A912897C070ADBF76221572C52609D && \
    add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       debian-$(lsb_release -cs) \
       main" && \
    apt-get update && \
    apt-get -y install docker-engine=1.11.2-0~jessie

# Install Captain v1.1.0
RUN curl -sSL https://github.com/harbur/captain/releases/download/v1.1.0/captain_linux_amd64 > /usr/local/bin/captain && \
    chmod +x /usr/local/bin/captain

# Install AWS
RUN curl -sSL https://s3.amazonaws.com/aws-cli/awscli-bundle.zip > awscli-bundle.zip && \
    unzip awscli-bundle.zip && \
    ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && \
    rm -rf awscli-bundle*

# Install Kubectl
RUN curl -sSL https://storage.googleapis.com/kubernetes-release/release/v1.5.2/bin/linux/amd64/kubectl > /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

# Install Kops
RUN curl -sSL https://github.com/kubernetes/kops/releases/download/1.5.1/kops-linux-amd64 > /usr/local/bin/kops && \
    chmod +x /usr/local/bin/kops

# Link .dockerconfig to Jenkins user
RUN ln -sf /root/.dockercfg /home/jenkins/
