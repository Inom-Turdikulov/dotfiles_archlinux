if PackerPluginLoaded("zeavim.vim") then
    vim.keymap.set("n", "<leader>zh", function()
        vim.cmd "Zeavim"
    end)
end
