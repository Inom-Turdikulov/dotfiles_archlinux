if PackerPluginLoaded("trouble.nvim") then
    vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
        { silent = true, noremap = true }
    )
end
