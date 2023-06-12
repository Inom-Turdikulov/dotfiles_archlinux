if PackerPluginLoaded("copilot.lua") then
    require('copilot').setup({
        panel = {
            enabled = true,
            auto_refresh = false,
            keymap = {
                jump_prev = "[[",
                jump_next = "]]",
                accept = "<CR>",
                refresh = "gr",
                open = "<M-CR>"
            },
            layout = {
                position = "bottom", -- | top | left | right
                ratio = 0.4
            },
        },
        suggestion = {
            enabled = true,
            auto_trigger = true,
            debounce = 75,
            keymap = {
                accept = "<tab>",
                accept_word = false,
                accept_line = false,
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
            },
        },
        filetypes = {
            yaml = true,
            markdown = true,
            python = true,
            lua = true,
            c = true,
            cpp = true,
            rust = true,
            json = true,
            sh = function()
                if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
                    -- disable for .env files
                    return false
                end
                return true
            end,
           ["*"] = false, -- disable for all other filetypes and ignore default `filetypes`
        },
        copilot_node_command = 'node', -- Node.js version must be > 16.x
        server_opts_overrides = {},
    })

    -- Toggle Copilot
    vim.keymap.set("", "<M-\\>", ":Copilot toggle<CR>",
        { noremap = true, silent = true })
end
