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

vim.keymap.set("n", "<leader>zn", function() require('telekasten').new_note() end)
vim.keymap.set("n", "<leader>zN", function() require('telekasten').new_templated_note() end)
vim.keymap.set("n", "<leader>zf", function() require('telekasten').find_notes() end)
vim.keymap.set("n", "<leader>zF", function() require('telekasten').follow_link() end)
vim.keymap.set("n", "<leader>zg", function() require('telekasten').search_notes() end)
vim.keymap.set("n", "<leader>zy", function() require('telekasten').yank_notelink() end)
vim.keymap.set("n", "<leader>zi", function() require('telekasten').paste_img_and_link() end)
vim.keymap.set("n", "<leader>zt", function() require('telekasten').toggle_todo() end)
vim.keymap.set("n", "<leader>zb", function() require('telekasten').show_backlinks() end)
vim.keymap.set("n", "<leader>zF", function() require('telekasten').find_friends() end)
vim.keymap.set("n", "<leader>zI", function() require('telekasten').insert_img_link({ i = true }) end)
vim.keymap.set("n", "<leader>zp", function() require('telekasten').preview_img() end)
vim.keymap.set("n", "<leader>zm", function() require('telekasten').browse_media() end)
vim.keymap.set("n", "<leader>za", function() require('telekasten').show_tags() end)
vim.keymap.set("n", "<leader>zr", function() require('telekasten').rename_note() end)
