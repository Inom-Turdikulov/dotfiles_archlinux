if PackerPluginLoaded("todo-comments.nvim") then
    require("todo-comments").setup {
        highlight = {
            pattern = { [[.*<(KEYWORDS)\s*:]], [[::.*<(KEYWORDS)\s*:.*::]] }, -- pattern or table of patterns, used for highlightng (vim regex)
            comments_only = false,                                            -- uses treesitter to match keywords in comments only
            after = "none"
        },
        search = {
            command = "rg",
            -- regex that will be used to match keywords.
            -- don't replace the (KEYWORDS) placeholder
            pattern = [[\b(KEYWORDS):]], -- ripgrep regex
            -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
        },
        colors = {
            error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
            warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
            info = { "DiagnosticInfo", "#2563EB" },
            hint = { "DiagnosticHint", "#10B981" },
            default = { "Identifier", "#7C3AED" },
            test = { "Identifier", "#FF00FF" },
            gray = { "Identifier", "#7C3AED" },
            success = { "String", "#7C3AED" },
        },
        keywords = {
            FIX = {
                icon = "F",                                 -- icon used for the sign, and in search results
                color = "error",                            -- can be a hex color, or a named color (see below)
                alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                -- signs = false, -- configure signs for some keywords individually
            },
            KILL = { icon = "K", color = "#5c6370" },
            DONE = { icon = "D", color = "success" },
            TODO = { icon = "I", color = "info" },
            NEXT = { icon = "N", color = "warning" },
            HACK = { icon = "!", color = "warning" },
            WARN = { icon = "W", color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = "P", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = "N", color = "hint", alt = { "INFO" } },
            TEST = {
                icon = "T",
                color = "test",
                alt = { "TESTING", "PASSED", "FAILED" }
            },
        },
    }

    local function toggle_todo(todo_text)
        if (todo_text == nil) then
            todo_text = "TODO: "
        end

        local current_line = vim.api.nvim_get_current_line()

        local todo_index = string.find(current_line, todo_text)
        if (todo_index ~= nil) then
            local new_line = string.gsub(current_line, todo_text, "")
            vim.api.nvim_set_current_line(new_line)
        else
            local to_remove_items = { "TODO: ", "NEXT: ", "NOTE: ", "FIXME: ",
                "WARN: ", "DONE: ", "INFO: ", "PERF: ", "KILL: ", "HACK: " }
            for _, item in ipairs(to_remove_items) do
                local item_index = string.find(current_line, item)
                if (item_index ~= nil) then
                    current_line = string.gsub(current_line, item, "")
                    vim.api.nvim_set_current_line(current_line)
                    current_line = vim.api.nvim_get_current_line()
                end
            end

            local last_leading_space = string.find(current_line, "%S")
            local leading_dash = string.find(current_line, "^-")
            if (leading_dash ~= nil) then
                last_leading_space = leading_dash + 2
            end

            current_line = string.sub(current_line, 0, last_leading_space - 1) ..
            todo_text .. string.sub(current_line, last_leading_space)
            vim.api.nvim_set_current_line(current_line)
        end
    end

    vim.keymap.set("n", "<leader>tt", toggle_todo, { desc = "Toggle TODO" })

    vim.keymap.set("n", "<leader>tn", function()
        toggle_todo("NEXT: ")
    end, { desc = "Toggle NEXT" })

    vim.keymap.set("n", "<leader>tN", function()
        toggle_todo("NOTE: ")
    end, { desc = "Toggle NOTE" })

    vim.keymap.set("n", "<leader>tf", function()
        toggle_todo("FIXME: ")
    end, { desc = "Toggle FIXME" })

    vim.keymap.set("n", "<leader>tw", function()
        toggle_todo("WARN: ")
    end, { desc = "Toggle WARN" })

    vim.keymap.set("n", "<leader>td", function()
        toggle_todo("DONE: ")
    end, { desc = "Toggle DONE" })

    vim.keymap.set("n", "<leader>tk", function()
        toggle_todo("KILL: ")
    end, { desc = "Toggle DONE" })

    vim.keymap.set("n", "<leader>ti", function()
        toggle_todo("INFO: ")
    end, { desc = "Toggle INFO" })

    vim.keymap.set("n", "<leader>tp", function()
        toggle_todo("PERF: ")
    end, { desc = "Toggle PERF" })

    vim.keymap.set("n", "<leader>th", function()
        toggle_todo("HACK: ")
    end, { desc = "Toggle HACK" })
end
