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
"Plugin 'altercation/vim-colors-solarized'
Plugin 'lifepillar/vim-solarized8'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/a.vim'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
" Plugin 'ajh17/vimcompletesme'
set rtp+=~/.fzf
Plugin 'junegunn/fzf.vim'

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
set vb t_vb=""
set ttyfast
set t_Co=256
set encoding=utf-8
set incsearch

syntax enable
set termguicolors
set background=dark
colorscheme solarized8

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

nmap <C-p> :FZF<CR>
nmap :f<CR> :Ag <C-r><C-w><CR>

" let g:ycm_server_python_interpreter="/opt/bb/bin/python"
" let g:ycm_autoclose_preview_window_after_insertion = 1
" nmap gy :YcmCompleter GoTo<CR>
" map <F9> :YcmCompleter FixIt<CR>

map <C-I> :pyf /opt/bb/share/bde-format/bde-format.py<CR>
imap <C-I> :pyf /opt/bb/share/bde-format/bde-format.py<CR>

if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd', '-background-index']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    \ })
"        autocmd FileType c setlocal omnifunc=lsp#complete
"        autocmd FileType cpp setlocal omnifunc=lsp#complete
"        autocmd FileType objc setlocal omnifunc=lsp#complete
"        autocmd FileType objcpp setlocal omnifunc=lsp#complete
    augroup end
endif
let g:lsp_diagnostics_echo_cursor = 1
autocmd FileType c nnoremap <buffer> <silent> gd :LspDefinition<CR>
autocmd FileType cpp nnoremap <buffer> <silent> gd :LspDefinition<CR>
autocmd FileType c nnoremap <buffer> <silent> gc :LspDeclaration<CR>
autocmd FileType cpp nnoremap <buffer> <silent> gc :LspDeclaration<CR>

let g:asyncomplete_auto_popup = 0

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr>   pumvisible() ? "\<C-y>" : "\<cr>"

" autocmd FileType c let b:vcm_tab_complete = "omni"
" autocmd FileType cpp let b:vcm_tab_complete = "omni"
