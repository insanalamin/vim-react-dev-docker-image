FROM debian:bullseye-slim

RUN apt-get update
RUN apt-get install -y build-essential vim-nox curl git zsh tmux bpytop dnsutils netcat

RUN useradd -ms /bin/zsh developer 

USER developer
WORKDIR /home/developer

# Unattended install Oh My Zsh https://github.com/ohmyzsh/ohmyzsh#unattended-install
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install Git 
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime

# Install NVM
# https://stackoverflow.com/questions/25899912/how-to-install-nvm-in-docker
RUN pwd
ENV NVM_DIR /home/developer/.nvm
RUN mkdir /home/developer/.nvm
RUN ls -la ~
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install --lts \
    && npm install -g yarn

# Install Vim Awesome Configuration 
RUN sh ~/.vim_runtime/install_awesome_vimrc.sh

RUN mkdir /home/developer/projects
WORKDIR /home/developer/projects

CMD ["echo", "Image created"]
