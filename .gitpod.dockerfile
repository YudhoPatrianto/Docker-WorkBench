# Use OS Ubuntu 22.04 For Default OS
FROM ubuntu:jammy

# Set To noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Install Dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    locales sudo python-is-python3 python3 python2 repo git bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev tmux tmate openssh-server

# Set Locale and localtime
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8 && \
    ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# Set environment variables
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# Configuring User For Workspace
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod && \
    sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers

# Switch To gitpod User
USER gitpod

# Configure Git Information
RUN git config --global user.name YudhoPatrianto
RUN git config --global user.email kydh01123@gmail.com

# Start bash
CMD ["bash"]
