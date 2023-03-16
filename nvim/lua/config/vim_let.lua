vim.cmd([[

set laststatus=2  "永远显示状态栏
set t_Co=256      "在windows中用xshell连接打开vim可以显示色彩
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='minimalist' " 'minimalist'
let g:airline_powerline_fonts = 1
let g:VM_set_statusline=0
let g:VM_maps = {}
let g:VM_leader = {'default': ',', 'visual': ',', 'buffer': ','}
let g:VM_maps['Find Under']                  = '<C-s>'
let g:VM_maps['Find Subword Under']          = '<C-s>'
let g:VM_maps["Select All"]                  = '<M-s>'
let g:VM_maps["Visual Cursors"]              = '<C-s>'
]])
