if PackerPluginLoaded("which-key.nvim") then
    require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        icons = {
            breadcrumb = ">>", -- symbol used in the command line area that shows your active key combo
            separator = ">", -- symbol used between a key and it's label
            group = "+",  -- symbol prepended to a group
        },
    }
end
