syntax enable
set number
colorscheme lucario
set encoding=utf-8
set fileencoding=utf-8

" vim-plug for plugin management
" checkout doc here - https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'mzlogin/vim-markdown-toc'
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" Initialize plugin system
call plug#end()
