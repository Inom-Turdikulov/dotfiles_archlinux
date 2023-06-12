if PackerPluginLoaded("vim-dadbod") then
vim.cmd [[
let g:db_ui_auto_execute_table_helpers = 1
autocmd FileType dbout setlocal nofoldenable

" Autocompletion for vim-dadbod
autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
]]

-- My personal databases
if vim.g.dbs == nil then
  vim.g.dbs = vim.empty_dict()
end
local dbs = vim.g.dbs
dbs["dev-postgres"] = "postgres://dev:dev@localhost:5432/dev"
vim.g.dbs = dbs

vim.keymap.set("n", "<leader>qt", ":DBUIToggle<CR>", { noremap = true })
vim.keymap.set("n", "<leader>qi", ":DBUILastQueryInfo<CR>", { noremap = true })
end


