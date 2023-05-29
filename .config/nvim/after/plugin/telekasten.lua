if PackerPluginLoaded("telekasten.nvim") then
    local wiki_home = vim.fn.expand("~/Projects/main/wiki")
    require('telekasten').setup(
        {
            home = wiki_home,
            image_subdir = 'img',
            plug_into_calendar = true,
            media_previewer = "telescope-media-files",
            template_new_note = wiki_home .. '/' .. 'templates/new_note.md',
            template_new_daily = wiki_home .. '/' .. 'templates/daily.md',
            template_new_weekly = wiki_home .. '/' .. 'templates/weekly.md',
            sort = "modified",
            auto_set_filetype = false,
            follow_url_fallback = "call jobstart('linkhandler {{url}}')",
            -- dir names for special notes (absolute path or subdir name)
            dailies = wiki_home .. '/' .. 'daily',
            weeklies = wiki_home .. '/' .. 'weekly',
            new_note_filename = "title",
        })

    vim.keymap.set("n", "<leader>zf",
    function() require('telekasten').find_notes() end, { desc = "Find notes" })
    vim.keymap.set("n", "<leader>zF",
    function() require('telekasten').find_notes() end, { desc = "Find notes" })
    vim.keymap.set("n", "<leader>zg",
    function() require('telekasten').search_notes() end,
    { desc = "Search notes" })
    vim.keymap.set("n", "<leader>zz",
    function() require('telekasten').follow_link() end, { desc = "Follow link" })

    vim.keymap.set("n", "<leader>zw",
    function() require('telekasten').goto_thisweek({ journal_auto_open = true }) end,
    { desc = "Goto this week" })

    vim.keymap.set("n", "<leader>zW",
        function() require('telekasten').weekly() end,
        { desc = "Find weekly notes" })

    vim.keymap.set("n", "<leader>zn",
    function() require('telekasten').new_note() end, { desc = "Create new note" })
    vim.keymap.set("n", "<leader>zN",
    function() require('telekasten').new_templated_note() end,
    { desc = "Create new note from template" })
    vim.keymap.set("n", "<leader>zy",
    function() require('telekasten').yank_notelink() end,
    { desc = "Yank notelink" })

    vim.keymap.set("n", "<leader>zc",
    function() require('telekasten').show_calendar() end,
    { desc = "Show calendar" })
    vim.keymap.set("n", "<leader>zC", ":CalendarT<CR>", { desc = "Calendar" })

    vim.keymap.set("n", "<leader>zi", function()
        require('telekasten').insert_link()
    end, { desc = "Paste image and link" })

    vim.keymap.set("n", "<leader>zI",
    function() require('telekasten').paste_img_and_link() end,
    { desc = "Paste image and link" })
    vim.keymap.set("n", "<leader>zt",
    function() require('telekasten').toggle_todo() end, { desc = "Toggle TODO" })
    vim.keymap.set("v", "<leader>zt",
    function() require('telekasten').toggle_todo({ v = true }) end,
    { desc = "Toggle TODO (visual)" })
    vim.keymap.set("n", "<leader>z#",
    function() require('telekasten').show_tags() end, { desc = "Show tags" })

    vim.keymap.set("n", "<leader>zb",
    function() require('telekasten').show_backlinks() end,
    { desc = "Show backlinks" })
    vim.keymap.set("n", "<leader>zB",
    function() require('telekasten').find_friends() end,
    { desc = "Find friends" })
    vim.keymap.set("n", "<leader>zp",
    function() require('telekasten').preview_img() end,
    { desc = "Preview image" })
    vim.keymap.set("n", "<leader>zm",
    function() require('telekasten').browse_media() end,
    { desc = "Browse media" })

    vim.keymap.set("n", "<leader>zr",
    function() require('telekasten').rename_note() end, { desc = "Rename note" })


    -- get uuid based on os.date, useful to rename notes
    vim.keymap.set("n", "<Leader>zu", function()
        local uuid_format = "%Y%m%d%H%M"
        local uuid = os.date(uuid_format)
        vim.fn.setreg('"', uuid)
    end)
end
