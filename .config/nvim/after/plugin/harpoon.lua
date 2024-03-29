if PackerPluginLoaded("harpoon") then
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>a", mark.add_file,
        { desc = "Add file to harpoon" })

    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu,
        { desc = "Toggle harpoon menu" })

    vim.keymap.set("n", "<C-t>", function() ui.nav_file(1) end,
        { desc = "Harpoon Navigate to file 1" })
    vim.keymap.set("n", "<C-n>", function() ui.nav_file(2) end,
        { desc = "Harpoon Navigate to file 2" })
    vim.keymap.set("n", "<C-M-t>", function() ui.nav_file(3) end,
        { desc = "Harpoon Navigate to file 3" })
    vim.keymap.set("n", "<C-M-n>", function() ui.nav_file(4) end,
        { desc = "Harpoon Navigate to file 4" })

    vim.keymap.set("n", "<C-Bslash>",
        function() require("harpoon.term").gotoTerminal(1) end,
        { desc = "Harpoon Navigate to terminal 1" })

    vim.keymap.set("n", "<C-S-Bslash>",
        function() require("harpoon.term").gotoTerminal(2) end,
        { desc = "Harpoon Navigate to terminal 2" })
end
