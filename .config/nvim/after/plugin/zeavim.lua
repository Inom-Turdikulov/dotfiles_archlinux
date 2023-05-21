if PackerPluginLoaded("zeavim.vim") then
    vim.keymap.set("n", "<leader>zW", function()
        vim.cmd "Zeavim"
    end)
end
