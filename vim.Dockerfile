FROM debian:bullseye-slim

RUN apt-get update
RUN apt-get install -y build-essential vim-nox curl git zsh tmux bpytop dnsutils netcat fzf jq wrk net-tools xclip ack

COPY .vimrc /root/.vimrc

RUN touch /root/build-08-15

RUN ls -la /root

# Configure CoC directory
RUN mkdir -p /root/.config/coc/extensions
RUN mkdir -p /root/.config/coc/ultisnips
COPY typescriptreact.snippets /root/.config/coc/ultisnips/typescriptreact.snippets

RUN mkdir /root/projects

WORKDIR /root

# Unattended install Oh My Zsh https://github.com/ohmyzsh/ohmyzsh#unattended-install
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install NVM
# https://stackoverflow.com/questions/25899912/how-to-install-nvm-in-docker
RUN ls -la
RUN pwd
RUN mkdir -p /root/.nvm
ENV NVM_DIR /root/.nvm
# ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 16.13.2 

RUN curl --silent -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN node -v
RUN npm -v
RUN npm install -g yarn
RUN mkdir -p /root/.vim/pack/plugins/start

# Vim Plugin CoC
# https://github.com/neoclide/coc.nvim/issues/450#issuecomment-632498202
# https://unix.stackexchange.com/questions/14107/is-it-possible-to-execute-a-vim-script-in-a-non-interactive-mode
# https://github-wiki-see.page/m/neoclide/coc.nvim/wiki/Install-coc.nvim

RUN cd /root/.vim/pack/plugins/start && git clone --branch release https://github.com/neoclide/coc.nvim.git --depth=1
# RUN git clone --branch release https://github.com/neoclide/coc.nvim.git --depth=1 /root/.vim/pack/plugins/start/coc.nvim
RUN echo '{}' >> /root/.config/coc/memos.json
RUN echo '{"dependencies":{}}' >> /root/.config/coc/extensions/package.json
RUN cd /root/.config/coc/extensions && npm install coc-json coc-tsserver coc-html coc-css coc-snippets --no-lockfile --ignore-scripts --production --no-global --legacy-peer-deps

# Vim Plugin Typescript
#RUN git clone https://github.com/leafgarland/typescript-vim.git /root/.vim/pack/plugins/start/typescript-vim

# Vim Plugin JSX Pretty
RUN git clone https://github.com/MaxMEllon/vim-jsx-pretty /root/.vim/pack/plugins/start/vim-jsx-pretty

# Vim Plugin Javascript 
RUN git clone https://github.com/pangloss/vim-javascript /root/.vim/pack/plugins/start/vim-javascript

# Vim Plugin Yats
RUN git clone https://github.com/herringtondarkholme/yats.vim /root/.vim/pack/plugins/start/yats

# Other useful plugins
RUN git clone https://github.com/tpope/vim-fugitive /root/.vim/pack/plugins/start/vim-fugitive
#RUN git clone https://github.com/honza/vim-snippets /root/.vim/pack/plugins/start/vim-snippets
RUN git clone https://github.com/mlaursen/vim-react-snippets /root/.vim/pack/plugins/start/vim-react-snippets
RUN git clone https://github.com/terryma/vim-multiple-cursors /root/.vim/pack/plugins/start/vim-multiple-cursors
RUN git clone https://github.com/morhetz/gruvbox /root/.vim/pack/plugins/start/gruvbox
RUN git clone https://github.com/itchyny/lightline.vim /root/.vim/pack/plugins/start/lightline.vim
RUN git clone https://github.com/preservim/nerdtree /root/.vim/pack/plugins/start/nerdtree
RUN git clone https://github.com/tiagofumo/vim-nerdtree-syntax-highlight /root/.vim/pack/plugins/start/vim-nerdtree-syntax-highlight
RUN git clone https://github.com/ryanoasis/vim-devicons /root/.vim/pack/plugins/start/vim-devicons
RUN git clone https://github.com/junegunn/fzf.vim /root/.vim/pack/plugins/start/fzf.vim
RUN git clone https://github.com/junegunn/fzf /root/.vim/pack/plugins/start/fzf
RUN git clone https://github.com/airblade/vim-gitgutter /root/.vim/pack/plugins/start/vim-gitgutter
RUN git clone https://github.com/mileszs/ack.vim /root/.vim/pack/plugins/start/ack.vim

# Other useful Vim plugins
# https://techinscribed.com/how-to-set-up-vim-as-an-ide-for-react-and-typescript-in-2020/

WORKDIR /root/projects

# https://github.com/coder/code-server/issues/628#issuecomment-636526989

CMD ["echo", "Image created"]
