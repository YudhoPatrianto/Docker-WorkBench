# Use OS Debian 12/ Debian Bookworm For Default OS
FROM debian:latest

# Set To noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Install Dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    locales sudo python-is-python3 python3 git bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev tmux tmate openssh-server

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
RUN useradd -l -u 33333 -G sudo -md /home/rvlpromaster -s /bin/bash -p rvlpromaster rvlpromaster && \
    sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers

# Switch To rvlpromaster User
USER rvlpromaster
WORKDIR /home/rvlpromaster

# Customization Bash
RUN curl -s https://ohmyposh.dev/install.sh | bash
RUN mkdir -p /home/rvlpromaster/.poshthemes
RUN curl -L https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/if_tea.omp.json -o /home/rvlpromaster/.poshthemes/if_tea.omp.json
RUN echo 'eval "$(oh-my-posh init bash --config ~/.poshthemes/if_tea.omp.json)"' >> /home/rvlpromaster/.bashrc

# Start bash
CMD ["bash"]
