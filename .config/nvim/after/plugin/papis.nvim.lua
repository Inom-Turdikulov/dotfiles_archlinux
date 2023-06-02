if PackerPluginLoaded("papis.nvim") then
    require("papis").setup({
        -- These are configuration options of the `papis` program relevant to papis.nvim.
        -- Papis.nvim can get them automatically from papis, but this is very slow. It is
        -- recommended to copy the relevant settings from your papis configuration file.
        papis_python = {
            dir = "~/Projects/main/wiki/papis",
            info_name = "info.yaml", -- (when setting papis options `-` is replaced with `_`
            -- in the keys names)
            notes_name = [[notes.md]],
        },
        -- Enable the default keymaps
        enable_keymaps = true,
        enable_modules = {
            ["search"] = true,         -- Enables/disables the search module
            ["completion"] = true,     -- Enables/disables the completion module
            ["cursor-actions"] = true, -- Enables/disables the cursor-actions module
            ["formatter"] = true,      -- Enables/disables the formatter module
            ["colors"] = true,         -- Enables/disables default highlight groups (you
            -- probably want this)
            ["base"] = true,           -- Enables/disables the base module (you definitely
            -- want this)
            ["debug"] = false,         -- Enables/disables the debug module (useful to
            -- troubleshoot and diagnose issues)
        },
        -- Defines citation formats for various filetypes. When the value is a table, then
        -- the first entry is used to insert citations, whereas the second will be used to
        -- find references (e.g. by the `cursor-action` module). `%s` stands for the reference.
        -- Note that the first entry is a string (where e.g. `\` needs to be excaped as `\\`)
        -- and the second a lua pattern (where magic characters need to be escaped with
        -- `%`; https://www.lua.org/pil/20.2.html).
        cite_formats = {
            tex = { "\\cite{%s}", "\\cite[tp]?%*?{%s}" },
            markdown = "@%s",
            rmd = "@%s",
            plain = "%s",
            org = { "[cite:@%s]", "%[cite:@%s]" },
        },
        -- Filename patterns that trigger papis.nvim to start. `%info_name%` needs to be
        -- first item; it is replaced with `info_name` as defined in `papis_python`.
        init_filenames = { "%info_name%", "*.md" },
        -- Configuration of formatter module.
        ["formatter"] = {

            -- This function runs when first opening a new note. The `entry` arg is a table
            -- containing all the information about the entry (see above `data_tbl_schema`).
            -- This example is meant to be used with the `.norg` filetype.
            format_notes_fn = function(entry)
                -- Some string formatting templates (see above `results_format` option for
                -- more details)
                local title_format = {
                    { "author", "%s ",   "" },
                    { "year",   "(%s) ", "" },
                    { "title",  "%s",    "" },
                }
                -- Format the strings with information in the entry
                local title = require("papis.utils"):format_display_strings(
                    entry, title_format)
                -- Grab only the strings (and disregard highlight groups)
                for k, v in ipairs(title) do
                    title[k] = v[1]
                end
                -- Define all the lines to be inserted
                local lines = {
                    "---",
                    "title: " .. table.concat(title),
                    "description: ",
                    "tags:",
                    "- inbox",
                    "- research",
                    "created: " .. os.date("%Y-%m-%d"),
                    "---",
                    "",
                    "",
                }
                -- Insert the lines
                vim.api.nvim_buf_set_lines(0, 0, #lines, false, lines)
                -- Move cursor to the bottom
                vim.cmd("normal G")
            end,
        },
    })

    -- Start papis.nvim automatically, not when opening a file with specific name
    vim.cmd(":PapisStart")
end
