if PackerPluginLoaded("trouble.nvim") then
    require("trouble").setup {
        icons = false,
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    }
    vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle document_diagnostics<cr>",
        { silent = true, noremap = true }
    )
    vim.keymap.set("n", "<leader>xQ", "<cmd>TroubleToggle workspace_diagnostics<cr>",
        { silent = true, noremap = true }
    )
end
