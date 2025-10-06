call plug#begin()
Plug 'lifepillar/vim-gruvbox8'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
call plug#end()

set background=dark
colorscheme gruvbox8

set number
set mouse=a
set incsearch
set switchbuf=usetab,newtab
set expandtab
set tabstop=4
set shiftwidth=4
set completeopt-=preview
"fixes mouse issue in Windows Terminal
set ttymouse=sgr
set backspace=2

"nnoremap <C-p> :GFiles PATH<CR>
"command! -bang -nargs=? -complete=dir Files
"      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--info=inline']}), <bang>0)

"nnoremap RR :Rg <C-r><C-w><CR>

let g:ycm_clangd_binary_path='/usr/bin/clangd-18'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_use_ultisnips_completer=0
let g:ycm_enable_semantic_highlighting=1
let g:ycm_always_populte_location_list=1
nnoremap gy :YcmCompleter GoTo<CR>
nnoremap gd :YcmCompleter GoToDefinition<CR>
nnoremap <C-f> :YcmCompleter FixIt<CR>
nnoremap <C-s> <Plug>(YCMFindSymbolInWorkspace)
nnoremap yc <Plug>(YCMCallHierarchy)
let g:ycm_key_list_select_completion = ['<Enter>', '<Down>']

function ClangFormatFile()
      let l:lines="all"
      py3f /usr/share/clang/clang-format-18/clang-format.py
endfunction

map <silent> <C-F8> :call ClangFormatFile()<CR>
nnoremap <A-Down> :m .+1<CR>
nnoremap <A-Up> :m .-2<CR>
inoremap <A-Down> <Esc>:m .+1<CR>gi
inoremap <A-Up> <Esc>:m .-2<CRgi
vnoremap <A-Down> :m '>+1<CR>gvv
vnoremap <A-Up> :m '<-2<CR>gv

set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ]]
      \ },
      \ 'component_function': {
      \     'gitbranch': 'FugitiveHead'
      \ },
      \ }

