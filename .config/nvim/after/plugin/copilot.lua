if PackerPluginLoaded("copilot.vim") then
    vim.g.copilot_filetypes = { ['dap-repl'] = false, }

    -- Enable copilot for some filetypes
    vim.api.nvim_set_var("copilot_filetypes", {
        ["markdown"] = true,
    })

    -- Toggle Copilot
    local copilot_on = true
    vim.api.nvim_create_user_command("CopilotToggle", function()
        if copilot_on then
            vim.cmd("Copilot disable")
            print("Copilot OFF")
        else
            vim.cmd("Copilot enable")
            print("Copilot ON")
        end
        copilot_on = not copilot_on
    end, { nargs = 0 })
    vim.keymap.set("", "<M-\\>", ":CopilotToggle<CR>",
    { noremap = true, silent = true })
end
