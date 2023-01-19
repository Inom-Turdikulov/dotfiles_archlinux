local wiki_home = vim.fn.expand("~/Projects/main/wiki/content/")
require('telekasten').setup(
    {
        home = wiki_home,
        image_subdir = nil,
        plug_into_calendar = true,
        media_previewer = "viu-previewer",
        template_new_note =  wiki_home .. '/' .. 'templates/new_note.md',
        template_new_daily = wiki_home .. '/' .. 'templates/daily.md',
        template_new_weekly= wiki_home .. '/' .. 'templates/weekly.md',
        sort = "modified",
        auto_set_filetype = false,
    })

vim.keymap.set("n", "<leader>zn", function() require('telekasten').new_note() end, { desc = "Create new note" })
vim.keymap.set("n", "<leader>zN", function() require('telekasten').new_templated_note() end, { desc = "Create new note from template" })
vim.keymap.set("n", "<leader>zf", function() require('telekasten').find_notes() end, { desc = "Find notes" })
vim.keymap.set("n", "<leader>zF", function() require('telekasten').follow_link() end, { desc = "Follow link" })
vim.keymap.set("n", "<leader>zg", function() require('telekasten').search_notes() end, { desc = "Search notes" })
vim.keymap.set("n", "<leader>zy", function() require('telekasten').yank_notelink() end, { desc = "Yank notelink" })
vim.keymap.set("n", "<leader>zi", function() require('telekasten').paste_img_and_link() end, { desc = "Paste image and link" })
vim.keymap.set("n", "<leader>zt", function() require('telekasten').toggle_todo() end, { desc = "Toggle TODO" })
vim.keymap.set("n", "<leader>zb", function() require('telekasten').show_backlinks() end, { desc = "Show backlinks" })
vim.keymap.set("n", "<leader>zF", function() require('telekasten').find_friends() end, { desc = "Find friends" })
vim.keymap.set("n", "<leader>zI", function() require('telekasten').insert_img_link({ i = true }) end, { desc = "Insert image link" })
vim.keymap.set("n", "<leader>zp", function() require('telekasten').preview_img() end, { desc = "Preview image" })
vim.keymap.set("n", "<leader>zm", function() require('telekasten').browse_media() end, { desc = "Browse media" })
vim.keymap.set("n", "<leader>za", function() require('telekasten').show_tags() end, { desc = "Show tags" })
vim.keymap.set("n", "<leader>zr", function() require('telekasten').rename_note() end, { desc = "Rename note" })
