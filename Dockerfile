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

USER jenkins
