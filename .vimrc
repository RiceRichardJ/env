"Mouse, Line Numbers"
set mouse=a
set number
set ruler

"Coloring"
syntax on
colorscheme desert

"Set Tab Size"
set expandtab
set tabstop=4

"Auto Indent"
set shiftwidth=4
filetype plugin indent on

"Right Arrow to Next Line"
set whichwrap+=<,>,h,l,[,]

" shift+arrow selection
nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
imap <S-Up> <Esc>v<Up>
imap <S-Down> <Esc>v<Down>
imap <S-Left> <Esc>v<Left>
imap <S-Right> <Esc>v<Right>

"Highlighted Search"
set hls is

" https://stackoverflow.com/questions/99161/how-do-you-make-vim-unhighlight-what-you-searched-for "
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

"Autocomplete Menu"
set wildmenu

"Wrap after words"
set linebreak

"Global Clipboard"
"set clipboard=unnamedplus

"Highlight on doubleclick"
:map <silent><2-LeftMouse> *

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

map <silent><RightMouse> :noh<return><esc>

" Tab & Shift-Tab for Buffer Switching "
nnoremap  <silent>   <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
"nnoremap  <silent> <C-s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" Tab for Window Pane Swiching "
"""nnoremap <silent><tab> <C-w>w 
"nnoremap <silent><s-tab> <C-w>w 

" Share Clipboard w OSX "
"map <C-x> :!pbcopy<CR>
"vmap <C-c> :w !pbcopy<CR><CR>

set backspace=indent,eol,start
