# Use OS Debian 12/ Debian Bookworm For Default OS
FROM debian:latest

# Install Dependencies
RUN apt-get update && \
    apt-get upgrade -y
RUN apt-get install sudo python-is-python3 python3 git bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev tmux tmate openssh-server -y

# Installing Repo
RUN mkdir -p ~/.bin && \
    PATH="${HOME}/.bin:${PATH}" && \
    curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo && \
    chmod a+rx ~/.bin/repo

# Configuring User For Workspace
RUN adduser rvlpromaster && \
    usermod -aG rvlpromaster && \
    sed -i '/^# User privilege specification/a rvlpromaster ALL=(ALL:ALL) ALL' /etc/sudoers && \
    sed -i '/^# Allow members of group sudo to execute any command/a %rvlpromaster ALL=(ALL:ALL) ALL' /etc/sudoers

# Switch To rvlpromaster User
USER rvlpromaster
WORKDIR /home/rvlpromaster

# Customization Bash
RUN curl -s https://ohmyposh.dev/install.sh | bash
RUN curl -L https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/if_tea.omp.json -o /home/User123/.poshthemes/if_tea.omp.json
RUN echo 'eval "$(oh-my-posh init bash --config ~/.poshthemes/if_tea.omp.json)"' >> /home/rvlpromaster/.bashrc

# Start 
CMD ["bash"]

