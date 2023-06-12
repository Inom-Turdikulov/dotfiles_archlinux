if PackerPluginLoaded("telescope.nvim") then
    local builtin = require('telescope.builtin')

    local function switch_to_first_window()
        local windows = vim.api.nvim_list_wins()
        local num_windows = #windows
        if num_windows > 1 then
            vim.api.nvim_set_current_win(windows[1])
        end
    end

    vim.keymap.set("n", "<c-'>", function()
        switch_to_first_window()
    end, { noremap = true, silent = true }, { desc = 'Switch to first window' })

    -- find telescope builtins
    vim.keymap.set("n", "<leader>fF", function()
        builtin.builtin()
    end, { noremap = true, silent = true }, { desc = 'Telescope builtins' })

    vim.keymap.set('n', '<leader>fs', function()
        switch_to_first_window()
        builtin.grep_string({ search = vim.fn.input("Grep > ") });
    end)

    -- Search - [ ] todo items in markdown files, autofill [ ] and press enter
    vim.keymap.set('n', '<leader>fS', function()
        switch_to_first_window()
        builtin.grep_string({ search = '- [ ]' });
    end)

    vim.keymap.set("n", "<M-e>", function()
        builtin.oldfiles({ only_cwd = true })
    end, { noremap = true, silent = true }, { desc = 'Telescope oldfiles' })

    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Keymaps' })

    vim.keymap.set('n', '<leader>fK', builtin.commands, { desc = 'Commands' })

    vim.keymap.set('n', '<leader>fc', builtin.command_history,
        { desc = 'Command history' })

    vim.keymap.set({ "n", "i", "v" }, '<M-p>', function()
        if vim.fn.filereadable('.git/HEAD') == 1 then
            switch_to_first_window()
            builtin.git_files()
        else
            builtin.find_files()
        end
    end, {desc='Telescope find files'})

    vim.keymap.set('n', '<M-P>', function()
        switch_to_first_window()
        builtin.resume()
    end, {desc='Telescope resume'})

    vim.keymap.set('n', '<M-b>', function()
        switch_to_first_window()
        builtin.buffers()
    end, {desc='Telescope buffers'})

    require("telescope").setup {
        defaults = {
            file_ignore_patterns = {
                "./node_modules",
                "papis/*.pdf",
            },
            -- preview = {
            --     mime_hook = function(filepath, bufnr, opts)
            --         local is_image = function(filepath)
            --             local image_extensions = { 'png', 'jpg' } -- Supported image formats
            --             local split_path = vim.split(filepath:lower(), '.', { plain = true })
            --             local extension = split_path[#split_path]
            --             return vim.tbl_contains(image_extensions, extension)
            --         end
            --         if is_image(filepath) then
            --             local term = vim.api.nvim_open_term(bufnr, {})
            --             local function send_output(_, data, _)
            --                 for _, d in ipairs(data) do
            --                     vim.api.nvim_chan_send(term, d .. '\r\n')
            --                 end
            --             end
            --             vim.fn.jobstart(
            --                 {
            --                     'viu', filepath -- Terminal image viewer command
            --                 },
            --                 { on_stdout = send_output, stdout_buffered = true, pty = true })
            --         else
            --             require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid,
            --                 "Binary cannot be previewed")
            --         end
            --     end
            -- },
        },
        extensions = {
            media_files = {
                find_cmd = "fd"
            },
            file_browser = {
                theme = "ivy",
                -- disables netrw and use telescope-file-browser in its place
                hijack_netrw = false,
                mappings = {
                    ["i"] = {
                        -- your custom insert mode mappings
                    },
                    ["n"] = {
                        -- your custom normal mode mappings
                    },
                },
            },
        },
    }

    if PackerPluginLoaded("telescope-file-browser.nvim") then
        require("telescope").load_extension("file_browser")

        -- open file_browser with the path of the current buffer
        vim.keymap.set("n", "<leader>pV", function()
            require("telescope").extensions.file_browser.file_browser({
                path = vim.fn.expand("%:p:h"),
                select_buffer = true,
            })
        end, {})
    end

    if PackerPluginLoaded("telescope-media-files.nvim") then
        require('telescope').load_extension('media_files')
    end
end
