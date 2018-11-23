syntax on

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'itchyny/lightline.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/a.vim'
Plugin 'Valloric/YouCompleteMe'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


"Information on the following setting can be found with
":help set
set tabstop=4
set expandtab
set autoindent
set shiftwidth=4  "this is the level of autoindent, adjust to taste
set ruler
set number
set backspace=indent,eol,start
set visualbell
set switchbuf=usetab,newtab
set tags=./tags,./../tags,./../../tags,./../../../tags,tags
set mouse=a
" Uncomment below to make screen not flash on error
set vb t_vb=""
set ttyfast
set t_Co=256
set encoding=utf-8
set incsearch

syntax enable
set background=dark
colorscheme solarized

"let g:NERDTreeDirArrowExpandable = '>'
"let g:NERDTreeDirArrowCollapsible = 'V'
nmap <C-e> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'solarized',
          \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \     'readonly': 'LightlineReadonly',
      \     'modified': 'LightlineModified',
      \     'fugitive': 'LightlineFugitive',
      \     'filename': 'LightlineFilename'
      \ },
          \ 'separator': { 'left': "", 'right': "" },
      \ 'subseparator': { 'left': "|", 'right': "|" }
      \ }


function! LightlineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightlineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "\ue0a2"
  else
    return ""
  endif
endfunction

function! LightlineFugitive()
 if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? "\ue0a0 ".branch : ''
  endif
  return ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction\ }

set rtp+=~/.fzf
nmap <C-p> :FZF<CR>

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_auto_trigger = 0
nmap gy :YcmCompleter GoTo<CR>
