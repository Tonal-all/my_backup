vim.cmd([[
nnoremap <silent> <space>s :LazyGit<CR>
nnoremap <silent> <space>b :Git blame<CR>
nnoremap <silent> <space>d :Gvdiffsplit<CR>
nnoremap <silent> <space>r :Git log --graph<CR><C-w>T
]])

require("telescope").load_extension("lazygit")
require('gitsigns').setup()
vim.cmd [[ autocmd BufEnter * :lua require('lazygit.utils').project_root_dir() ]]
