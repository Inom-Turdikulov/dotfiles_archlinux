if PackerPluginLoaded("sniprun") then
    require 'sniprun'.setup({
        interpreter_options = {
            C_original = {
                compiler = "gcc"
            },
            Python3_original = {
                interpreter = "python",
            },
        },
    })

    -- Select block by viB or vaB, and run SnipRun by F key
    vim.api.nvim_set_keymap('v', 'f', '<Plug>SnipRun', { silent = true })

    vim.api.nvim_set_keymap('n', '<leader>ze', '<Plug>SnipRunOperator',
    { silent = true })
    vim.api.nvim_set_keymap('n', '<leader>zee', '<Plug>SnipRun', { silent = true })
end
