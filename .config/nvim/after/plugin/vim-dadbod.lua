if PackerPluginLoaded("vim-dadbod") then
vim.cmd [[
let g:db_ui_env_variable_url = 'DATABASE_URL'
let g:db_ui_env_variable_name = 'DATABASE_NAME'
let g:db_ui_auto_execute_table_helpers = 1
autocmd FileType dbout setlocal nofoldenable
]]
end
