FROM node:16.13.2-stretch-slim 

RUN apt-get update
RUN apt-get install -y curl git ack autoconf automake cmake libtool libtool-bin pkg-config software-properties-common xclip locales unzip 

WORKDIR /root/src

# Fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /root/.fzf
RUN /root/.fzf/install
RUN cat /root/.bashrc 

# Ctags
RUN git clone https://github.com/universal-ctags/ctags.git
RUN cd /root/src/ctags && ./autogen.sh && ./configure && make && make install

# NeoVim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
  && chmod u+x nvim.appimage \
  && /root/src/nvim.appimage --appimage-extract \
  && mv /root/src/squashfs-root / \ 
  && ln -s /squashfs-root/AppRun /usr/bin/nvim
RUN curl -fLo /root/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Ripgrep
RUN curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb \
  && ls -la \
  && dpkg -i ripgrep_13.0.0_amd64.deb

# Treesitter
RUN npm install -g tree-sitter-cli

# LSP
RUN npm install -g typescript typescript-language-server eslint prettier dockerfile-language-server-nodejs vscode-langservers-extracted

# ===============================================================================

# Jetbrains Mono
RUN mkdir -p /usr/share/fonts && curl -LO https://download.jetbrains.com/fonts/JetBrainsMono-1.0.3.zip && unzip JetBrainsMono-1.0.3.zip && mv JetBrainsMono-1.0.3/ttf/JetBrainsMono-*.ttf /usr/share/fonts/

# Code-minimap
RUN curl -LO https://github.com/wfxr/code-minimap/releases/download/v0.6.4/code-minimap_0.6.4_amd64.deb && dpkg -i code-minimap_0.6.4_amd64.deb

# Glow
RUN curl -LO https://github.com/charmbracelet/glow/releases/download/v1.4.1/glow_1.4.1_linux_amd64.deb && dpkg -i glow_1.4.1_linux_amd64.deb

# Prettierd
RUN npm install -g @fsouza/prettierd

# GH CLI
RUN curl -LO https://github.com/cli/cli/releases/download/v2.4.0/gh_2.4.0_linux_amd64.deb && dpkg -i gh_2.4.0_linux_amd64.deb

# Lazygit
RUN curl -LO https://github.com/jesseduffield/lazygit/releases/download/v0.32.2/lazygit_0.32.2_Linux_x86_64.tar.gz
RUN mkdir -p /root/src/lazygit
RUN tar -xvf lazygit_0.32.2_Linux_x86_64.tar.gz -C /root/src/lazygit
RUN cp /root/src/lazygit/lazygit /usr/bin

# ===============================================================================

# VIM Configuration
COPY nvim/init.lua /root/.config/nvim
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
