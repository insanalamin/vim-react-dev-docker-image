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
