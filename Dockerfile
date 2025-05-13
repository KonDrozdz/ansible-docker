FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    ansible \
    openssh-client \
    sshpass \
    python3 \
    python3-pip \
    docker.io \
    iputils-ping \
    && mkdir -p /root/.ssh

COPY setup.sh /setup.sh
RUN chmod +x /setup.sh

CMD ["/bin/bash", "/setup.sh"]
# This Dockerfile sets up an Ubuntu 22.04 container with Ansible, SSH, and Docker installed.