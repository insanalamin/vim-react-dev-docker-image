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
RUN mkdir -p /home/developer/.nvm
ENV NVM_DIR /home/developer/.nvm
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

# Install Vim Awesome Configuration 
#RUN sh ~/.vim_runtime/install_awesome_vimrc.sh
#RUN mkdir -p /home/developer/.vim/pack/plugins/start

# Vim Plugin CoC
# https://github.com/neoclide/coc.nvim/issues/450#issuecomment-632498202
# https://unix.stackexchange.com/questions/14107/is-it-possible-to-execute-a-vim-script-in-a-non-interactive-mode
# https://github-wiki-see.page/m/neoclide/coc.nvim/wiki/Install-coc.nvim

RUN cd /home/developer/.vim/pack/plugins/start && git clone --branch release https://github.com/neoclide/coc.nvim.git --depth=1
# RUN git clone --branch release https://github.com/neoclide/coc.nvim.git --depth=1 /home/developer/.vim/pack/plugins/start/coc.nvim
RUN mkdir -p cat /home/developer/.config/coc/extensions
RUN echo '{}' >> /home/developer/.config/coc/memos.json
RUN echo '{"dependencies":{}}' >> /home/developer/.config/coc/extensions/package.json
RUN cd /home/developer/.config/coc/extensions && npm install coc-json coc-tsserver coc-html coc-css --no-lockfile --ignore-scripts --production --no-global --legacy-peer-deps

# Vim Plugin Typescript
#RUN git clone https://github.com/leafgarland/typescript-vim.git /home/developer/.vim/pack/plugins/start/typescript-vim

# Vim Plugin JSX Pretty
RUN git clone https://github.com/MaxMEllon/vim-jsx-pretty /home/developer/.vim/pack/plugins/start/vim-jsx-pretty

# Vim Plugin Javascript 
RUN git clone https://github.com/pangloss/vim-javascript /home/developer/.vim/pack/plugins/start/vim-javascript

# Vim Plugin Yats
RUN git clone https://github.com/herringtondarkholme/yats.vim /home/developer/.vim/pack/plugins/start/yats

# Other useful plugins
RUN git clone https://github.com/tpope/vim-fugitive /home/developer/.vim/pack/plugins/start/vim-fugitive
RUN git clone https://github.com/SirVer/ultisnips /home/developer/.vim/pack/plugins/start/ultisnips
RUN git clone https://github.com/honza/vim-snippets /home/developer/.vim/pack/plugins/start/vim-snippets
RUN git clone https://github.com/mlaursen/vim-react-snippets /home/developer/.vim/pack/plugins/start/vim-react-snippets
RUN git clone https://github.com/terryma/vim-multiple-cursors /home/developer/.vim/pack/plugins/start/vim-multiple-cursors
RUN git clone https://github.com/morhetz/gruvbox /home/developer/.vim/pack/plugins/start/gruvbox
RUN git clone https://github.com/itchyny/lightline.vim /home/developer/.vim/pack/plugins/start/lightline.vim
RUN git clone https://github.com/preservim/nerdtree /home/developer/.vim/pack/plugins/start/nerdtree
RUN git clone https://github.com/tiagofumo/vim-nerdtree-syntax-highlight /home/developer/.vim/pack/plugins/start/vim-nerdtree-syntax-highlight
RUN git clone https://github.com/ryanoasis/vim-devicons /home/developer/.vim/pack/plugins/start/vim-devicons

RUN <<EOF cat >> /home/developer/.vimrc
set autoindent                                                                                                                                                                                                                        [10/94]
set expandtab                                                                                                                                                                                                                                
set shiftround                                                                                                                                                                                                                               
set shiftwidth=4                                                                                                                                                                                                                             
set smarttab                                                                                                                                                                                                                                 
set tabstop=4                                                                                                                                                                                                                                
set bg=dark                                                                                                                                                                                                                                  
set number                                                                                                                                                                                                                                   
set laststatus=2                                                                                                                                                                                                                             
set encoding=UTF-8                                                                                                                                                                                                                           
                                                                                                                                                                                                                                             
syntax enable

let g:yats_host_keyword = 1
let g:javascript_plugin_jsdoc = 1

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

colorscheme gruvbox
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
autocmd VimEnter * NERDTree
"autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
EOF

# Other useful Vim plugins
# https://techinscribed.com/how-to-set-up-vim-as-an-ide-for-react-and-typescript-in-2020/

RUN mkdir /home/developer/projects
WORKDIR /home/developer/projects

# https://github.com/coder/code-server/issues/628#issuecomment-636526989

CMD ["echo", "Image created"]
