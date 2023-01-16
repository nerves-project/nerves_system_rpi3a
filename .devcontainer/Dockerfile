# Based on https://github.com/NervesJP/docker-nerves
FROM elixir:1.14.2

ENV DEBCONF_NOWARNINGS yes

RUN apt-get update && \
    apt-get install -y build-essential automake autoconf git squashfs-tools ssh-askpass pkg-config curl sudo && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y libssl-dev libncurses5-dev bc m4 unzip cmake python cpio rsync && \
    rm -rf /var/lib/apt/lists/*

# Install fwup (https://github.com/fhunleth/fwup)
ENV FWUP_VERSION="1.9.0"
RUN wget https://github.com/fwup-home/fwup/releases/download/v${FWUP_VERSION}/fwup_${FWUP_VERSION}_amd64.deb && \
    apt-get install -y ./fwup_${FWUP_VERSION}_amd64.deb && \
    rm ./fwup_${FWUP_VERSION}_amd64.deb && \
    rm -rf /var/lib/apt/lists/*

ARG UID=1000
ARG GID=1000

RUN grep -o "^.*:.*:$(id -g):.*" /etc/group || groupadd -g "${GID}" nerves
RUN useradd --create-home --no-log-init -u "${UID}" -g "${GID}" nerves -G sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER nerves

# Install hex and rebar
RUN mix local.hex --force
RUN mix local.rebar --force

RUN mix archive.install hex nerves_bootstrap 1.10.5 --force

CMD ["/bin/bash"]