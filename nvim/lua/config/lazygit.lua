require("telescope").load_extension("lazygit")
vim.cmd [[ autocmd BufEnter * :lua require('lazygit.utils').project_root_dir() ]]
