if PackerPluginLoaded("todo-comments.nvim") then
    require("todo-comments").setup {
        highlight = {
            pattern = { [[.*<(KEYWORDS)\s*:]], [[::.*<(KEYWORDS)\s*:.*::]] }, -- pattern or table of patterns, used for highlightng (vim regex)
            comments_only = false,                                      -- uses treesitter to match keywords in comments only
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
                icon = "F",                             -- icon used for the sign, and in search results
                color = "error",                        -- can be a hex color, or a named color (see below)
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
            TEST = { icon = "T", color = "test",
                alt = { "TESTING", "PASSED", "FAILED" } },
        },
    }
end
