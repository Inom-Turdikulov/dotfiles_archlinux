if PackerPluginLoaded("vim-fugitive") then
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

    local Inomoz_Fugitive = vim.api.nvim_create_augroup("Inomoz_Fugitive", {})

    local autocmd = vim.api.nvim_create_autocmd
    autocmd("BufWinEnter", {
        group = Inomoz_Fugitive,
        pattern = "*",
        callback = function()
            if vim.bo.ft ~= "fugitive" then
                return
            end

            local bufnr = vim.api.nvim_get_current_buf()
            local opts = { buffer = bufnr, remap = false }
            vim.keymap.set("n", "<leader>p", function()
                vim.cmd.Git('push')
            end, opts)

            -- rebase always
            vim.keymap.set("n", "<leader>P", function()
                vim.cmd.Git({ 'pull --rebase' })
            end, opts)

            -- NOTE: It allows me to easily set the branch i am pushing and any tracking
            -- needed if i did not set the branch up correctly
            vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
        end,
    })

    vim.keymap.set("n", "gn", "<cmd>diffget //2<CR>") -- select left side of diff
    vim.keymap.set("n", "gt", "<cmd>diffget //3<CR>") -- select right side of diff

    -- fugitive git bindings
    vim.keymap.set("n", "<space>gg", ":Git<CR>")
    vim.keymap.set("n", "<space>gl", ":Gclog<CR>")
    -- vim.keymap.set("n", "<space>ga",  ":Git add %:p<CR><CR>")
    -- vim.keymap.set("n", "<space>gc",  ":Gcommit -v -q<CR>")
    -- vim.keymap.set("n", "<space>gt",  ":Gcommit -v -q %:p<CR>")
    -- vim.keymap.set("n", "<space>gd",  ":Gdiff<CR>")
    -- vim.keymap.set("n", "<space>ge",  ":Gedit<CR>")
    -- vim.keymap.set("n", "<space>gr",  ":Gread<CR>")
    -- vim.keymap.set("n", "<space>gw",  ":Gwrite<CR><CR>")
    -- vim.keymap.set("n", "<space>gl",  ":silent! Glog<CR>:bot copen<CR>")
    -- vim.keymap.set("n", "<space>gp",  ":Ggrep<Space>")
    -- vim.keymap.set("n", "<space>gm",  ":Gmove<Space>")
    -- vim.keymap.set("n", "<space>gb",  ":Git branch<Space>")
    -- vim.keymap.set("n", "<space>go",  ":Git checkout<Space>")
    -- vim.keymap.set("n", "<space>gps", ":Dispatch! git push<CR>")
    -- vim.keymap.set("n", "<space>gpl", ":Dispatch! git pull<CR>")
    --
end
