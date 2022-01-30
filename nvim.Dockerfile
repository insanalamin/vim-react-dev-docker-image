FROM node:16.13.2-bullseye-slim 

# https://dev.to/mainendra/neovim-as-ide-1cnp
# https://github.com/nanotee/nvim-lua-guide
# https://github.com/LunarVim/LunarVim
# https://github.com/nikvdp/nvim-lsp-config/blob/master/init.vim
# https://rafaelnexus.com/tutorials/what-is-neovim-and-how-to-install-it-with-python-support/
# https://gist.github.com/darcyparker/153124662b05c679c417
# https://www.youtube.com/watch?v=7KVgMAd16NQ
# https://github.com/crivotz/nv-ide
# https://www.notonlycode.org/neovim-lua-config/
# https://www.youtube.com/watch?v=NXysez2vS4Q
# https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom
# https://github.com/albingroen/quick.nvim

RUN apt-get update
RUN apt-get install -y build-essential gcc libssl-dev curl wget git zsh tmux bpytop dnsutils netcat fzf jq wrk net-tools xclip ack unzip httpie
RUN apt-get install -y autoconf automake cmake g++ gettext libncurses5-dev libtool libtool-bin libunibilium-dev libunibilium4 ninja-build pkg-config software-properties-common

# OhMyZsh!
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

WORKDIR /root/src

# Pyenv
RUN curl https://pyenv.run | bash
# RUN echo 'export PATH="/root/.pyenv/bin:$PATH"' >> /root/.zshrc
SHELL ["/usr/bin/zsh", "-l", "-c"]
ENV PATH="/root/.pyenv/bin:${PATH}"
ENV PATH="/root/.pyenv/shims:${PATH}"
RUN pyenv --version 
RUN pyenv update 

# OhMyTmux!
ENV EDITOR=nvim
RUN git clone https://github.com/gpakosz/.tmux.git /root/src/oh-my-tmux
RUN ln -s -f /root/src/oh-my-tmux/.tmux.conf /root/.tmux.conf
RUN cp /root/src/oh-my-tmux/.tmux.conf.local /root/.tmux.conf.local

# NeoVim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
RUN chmod u+x nvim.appimage
RUN ls -la
RUN /root/src/nvim.appimage --appimage-extract
RUN /root/src/squashfs-root/AppRun --version
RUN mv /root/src/squashfs-root /
RUN ln -s /squashfs-root/AppRun /usr/bin/nvim

# Jetbrains Mono
RUN wget https://download.jetbrains.com/fonts/JetBrainsMono-1.0.3.zip
RUN unzip JetBrainsMono-1.0.3.zip
RUN ls -la
RUN mv JetBrainsMono-1.0.3/ttf/JetBrainsMono-*.ttf /usr/share/fonts/

# Ctags
RUN git clone https://github.com/universal-ctags/ctags.git
RUN cd /root/src/ctags && ./autogen.sh && ./configure && make && make install

# Ripgrep
RUN curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
RUN ls -la
RUN dpkg -i ripgrep_13.0.0_amd64.deb

# Code-minimap
RUN curl -LO https://github.com/wfxr/code-minimap/releases/download/v0.6.4/code-minimap_0.6.4_amd64.deb
RUN ls -la
RUN dpkg -i code-minimap_0.6.4_amd64.deb

# Glow
RUN curl -LO https://github.com/charmbracelet/glow/releases/download/v1.4.1/glow_1.4.1_linux_amd64.deb 
RUN ls -la
RUN dpkg -i glow_1.4.1_linux_amd64.deb

# Prettierd
RUN npm install -g @fsouza/prettierd

# GH CLI
RUN curl -LO https://github.com/cli/cli/releases/download/v2.4.0/gh_2.4.0_linux_amd64.deb
RUN ls -la
RUN dpkg -i gh_2.4.0_linux_amd64.deb

# Treesitter
RUN npm install -g tree-sitter-cli

# LSP
RUN npm install -g typescript typescript-language-server eslint prettier
RUN npm install -g dockerfile-language-server-nodejs
RUN npm install -g vscode-langservers-extracted

RUN curl -LO https://github.com/sumneko/lua-language-server/releases/download/2.6.3/lua-language-server-2.6.3-linux-x64.tar.gz
RUN mkdir /root/src/lua-language-server
RUN tar -zxvf /root/src/lua-language-server-2.6.3-linux-x64.tar.gz -C lua-language-server
RUN chmod a+rx /root/src/lua-language-server/bin/lua-language-server
RUN cp /root/src/lua-language-server/bin/lua-language-server /usr/local/bin

# Python Environment
RUN apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
RUN pyenv install 3.9.10
RUN pyenv global 3.9.10
RUN python --version
RUN pip --version
RUN pip install httpx python-multipart mongoengine nats-python psycopg2-binary requests bcrypt

RUN pip --version
RUN pip install 'python-lsp-server[all]'
RUN npm install -g pyright
RUN python-lsp-server --version
RUN pyright --version

# VIM Configuration
RUN curl -fLo /root/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
COPY nvim/init.lua /root/.config/nvim/init.lua
COPY nvim/lua /root/.config/nvim/lua

# RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim /root/.local/share/nvim/site/pack/packer/start/packer.nvim
RUN nvim --headless +PlugInstall +qall
RUN nvim '+TSUpdateSync bash' +qall
RUN nvim '+TSUpdateSync html' +qall
RUN nvim '+TSUpdateSync javascript' +qall
RUN nvim '+TSUpdateSync lua' +qall
RUN nvim '+TSUpdateSync json' +qall
RUN nvim '+TSUpdateSync latex' +qall
RUN nvim '+TSUpdateSync make' +qall
RUN nvim '+TSUpdateSync python' +qall
RUN nvim '+TSUpdateSync php' +qall
RUN nvim '+TSUpdateSync yaml' +qall
RUN nvim '+TSUpdateSync vim' +qall
RUN nvim '+TSUpdateSync tsx' +qall
RUN nvim '+TSUpdateSync typescript' +qall
