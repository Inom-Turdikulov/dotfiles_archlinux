if PackerPluginLoaded("zen-mode.nvim") then
    require("zen-mode").setup {
        window = {
            width = 90,
            options = {
                number = true,
                relativenumber = true,
            }
        },
    }

    vim.keymap.set("n", "<leader>Z", function()
        require("zen-mode").toggle()
        vim.wo.wrap = false
        require('onedark').load()
    end)
end
