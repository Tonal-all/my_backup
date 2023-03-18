set laststatus=2  "永远显示状态栏
set t_Co=256      "在windows中用xshell连接打开vim可以显示色彩
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:VM_set_statusline=0
let g:VM_maps = {}
let g:VM_leader = {'default': ',', 'visual': ',', 'buffer': ','}
let g:VM_maps['Find Under']                  = '<C-s>'
let g:VM_maps['Find Subword Under']          = '<C-s>'
let g:VM_maps["Select All"]                  = '<M-s>'
let g:VM_maps["Visual Cursors"]              = '<C-s>'
let g:winresizer_vert_resize = 1
let g:winresizer_horiz_resize = 1
map ; <Leader>
set hidden
set updatetime=200
set showcmd
set noerrorbells
set number
set autoread
set novisualbell
set shiftwidth=4 softtabstop=4 tabstop=4 expandtab smarttab
set nocompatible
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Set regular expression engine automatically
set regexpengine=0
" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

if has('termguicolors')
    set termguicolors
endif
set background=dark
let g:gruvbox_italic=1


let g:edge_style = 'neon'
let g:edge_better_performance = 1
let g:airline_theme = 'edge'
colorscheme edge


" let g:airline_theme='minimalist' " 'minimalist'
" let g:gruvbox_material_background = 'soft'
" let g:gruvbox_material_better_performance = 1
" colorscheme gruvbox-material


" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e"

    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry
source ~/.config/nvim/vim_file/base/helper_functions.vim
"-------------------------------
packadd! matchit
"-------------------------------
" Delete trailing white space on save, useful for some filetypes ;)

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif
au FocusGained,BufEnter * checktime
" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

"-------------------------------
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
nnoremap H ^
nnoremap L $
omap H ^
omap L $
xmap H ^
xmap L $
vnoremap Y "+y
nnoremap Y "+y
nnoremap <Space>p "+p
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!


" vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
" vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Migrate <c-l> to <c-n> and add disable highlighting

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" Close the current buffer
map <leader>bd :<c-u>bd<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <Space>l :bnext<cr>
map <Space>h :bprevious<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <silent> <M-j> mz:m+<cr>`z
nmap <silent> <M-k> mz:m-2<cr>`z
vmap <silent> <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <silent> <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader> [使用 <leader> 的快捷方式]
map <leader>sa zg
map <leader>s? z=
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <Left>
inoremap <M-l> <Right>
nnoremap <M-h> :<C-u>tabprevious<cr>
nnoremap <M-l> :<C-u>tabnext<cr>

nnoremap <silent> <Space>n :noh<cr><c-l>
nnoremap <leader>v :<c-u>source ~/.config/nvim/init.vim<bar>AirlineRefresh<cr>
map <C-q> <C-w>q

vnoremap <M-l> :normal gvdp<cr>`[v`]
vnoremap <M-h> :normal gvdhP<cr>`[v`]

nmap <leader>ff <Plug>SnipRun
nmap <leader>f <Plug>SnipRunOperator
vmap  <leader>f <Plug>SnipRun

nnoremap <silent> <leader>m :<c-u>lua require("harpoon.mark").add_file()<CR>
nnoremap <silent> <Space>m :<c-u>lua require("harpoon.ui").toggle_quick_menu()<CR>

nnoremap <silent> <leader>l :<c-u>lua require("harpoon.ui").nav_next()<CR>
nnoremap <silent> <leader>h :<c-u>lua require("harpoon.ui").nav_prev()<CR>

