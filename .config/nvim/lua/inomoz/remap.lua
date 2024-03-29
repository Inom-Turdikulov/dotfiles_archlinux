vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pV", ":Lexplore %:p:h<CR>")

-- Fix cyrillic Ctrl mappings
vim.keymap.set("n", "<C-с>", "<C-d>")
vim.keymap.set("n", "<C-ш>", "<C-u>")

-- Map Ctrl-Backspace to delete the previous word in insert mode.
vim.keymap.set("i", "<C-BS>", "<C-W>")

vim.keymap.set("n", "<C-s>", "<cmd>w<CR>")
vim.keymap.set({ "i", "v" }, "<C-s>", "<Esc><cmd>w<CR>")

-- move lines
vim.keymap.set("v", "<C-J>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-K>", ":m '<-2<CR>gv=gv")

-- save cursor on center
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever, to replace selection with default register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- integrate system clipboard with <leader>y
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- delete to void register
vim.keymap.set({ "n", "v" }, "<leader>D", [["_d]])

-- Quickfix list navigation
-- TODO: need check and fix
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Replace word under cursor -> send to command mode
vim.keymap.set("n", "<leader>S",
[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true })

-- Launch script using $TERMINAL
vim.keymap.set("n", "<leader>o", "<cmd>!$TERMINAL %<CR>", { silent = true })

-- Open file in external program (xdg-open)
vim.keymap.set("n", "<leader>O", "<cmd>!xdg-open %<CR>", { silent = true })

local vim_config_dir = vim.fn.stdpath("config")
-- Open packer config
vim.keymap.set("n", "<leader>vpp",
"<cmd>e "..vim_config_dir.."/lua/inomoz/packer.lua<CR>");

-- open Ex in nvim config directory
vim.keymap.set("n", "<Leader>vpe", ":e " .. vim_config_dir .. "<CR>",
{ desc = "Open Ex in nvim config directory" })

vim.keymap.set("n", "<leader>vpr", "<cmd>lua ReloadConfig()<CR>",
{ desc = "Reload nvim config" })

-- Fun stuff
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");
vim.keymap.set("n", "<leader>mR", "<cmd>CellularAutomaton game_of_life<CR>");

-- External commands
vim.keymap.set("n", "<Leader>ov", ': !$TERMINAL -e visidata "%"<CR>')
vim.keymap.set("n", "<Leader>oc",
': silent !LDLIBS="-lcrypt -lcs50 -lm" clang "%" -o /tmp/a.out -lcs50 && kitty --hold -e /tmp/a.out<CR>')

-- Quickly Destsroy current buffer
vim.keymap.set("n", "<M-x>", "<cmd>bd<CR>")

-- Show/hide special characters
vim.keymap.set("n", "<leader>vn", function()
    if vim.wo.list then
        vim.wo.list = false
    else
        vim.wo.list = true
        vim.wo.listchars = GLOBAL_LISTCHARS
    end
end)

-- Switch keymap keymap=russian-jcukenwin or keymap=english
vim.keymap.set({ "n", "v", "i" }, "<C-l>", function()
    if vim.o.keymap == "russian-jcukenwin" then
        vim.o.keymap = ""
    else
        vim.o.keymap = "russian-jcukenwin"
    end
end)

-- Delete current file
vim.keymap.set("n", "<S-M-Del>",
"<cmd>call delete(expand('%:p')) | bdelete! %<CR>")

-- search build.sh file in current directory and parent directories
local function search_build_sh_recursively(path)
    local build_sh = path .. "/build.sh"
    local build_bat = path .. "/build.bat"

    if vim.fn.filereadable(build_sh) == 1 then
        return build_sh
    elseif vim.fn.filereadable(build_bat) == 1 then
        return build_bat
    end

    -- if path included "Projects" then stop searching
    local projects = vim.fn.expand("~/Projects")

    -- if windows platform use different path
    if vim.fn.has("win32") == 1 then
        projects = vim.fn.expand("/w")
    end

    if vim.fn.fnamemodify(path, ":h") == projects then
        return nil
    end
    -- if path is root then stop searching
    if path == "/" then
        return nil
    end

    return search_build_sh_recursively(vim.fn.fnamemodify(path, ":h"))
end

-- search build.sh file and run it, also run nvim-dap debugger
vim.keymap.set("n", "<Leader>bh", function()
    local build_sh = search_build_sh_recursively(vim.fn.getcwd())
    if build_sh then
        -- save current file if it is modified
        if vim.bo.modified then
            vim.cmd("w")
        end

        -- run build.sh and if it exits with code 0 then run nvim-dap debugger
        vim.cmd("silent !" .. build_sh)
        -- if vim.v.shell_error == 0 then
        --     vim.cmd("lua require('dap').continue()")
        -- end
    else
        print("builder not found")
    end
end)

-- search word under cursor in goldendict
vim.keymap.set("n", "<Leader>sd", function()
    local word = vim.fn.expand("<cword>")
    vim.cmd("silent !goldendict \"" .. word .. "\" &")
end)

-- search word under cursor in google images (browser)
vim.keymap.set("n", "<Leader>sg", function()
    local word = vim.fn.expand("<cword>")
    vim.cmd("silent !linkhandler \"https://www.google.com/search?q=" ..
    word .. "\"")
end)

-- search word under cursor in google images (browser)
vim.keymap.set("n", "<Leader>si", function()
    local word = vim.fn.expand("<cword>")
    vim.cmd("silent !linkhandler \"https://www.google.com/search?q=" ..
    word .. "&tbm=isch\"")
end)

-- translate word under cursor
vim.keymap.set("n", "<Leader>sD", function()
    local word = vim.fn.expand("<cword>")
    vim.cmd("r!english-word-generator.sh " .. word)
end)

-- search word under cursor in devdocs-desktop
vim.keymap.set("n", "<Leader>dd", function()
    word = vim.fn.expand("<cword>")
    vim.api.nvim_command("!devdocs-desktop \"" ..
    vim.bo.filetype .. " " .. word .. "\"")
end)

vim.keymap.set("n", "<Leader>dD", function()
    word = vim.fn.expand("<cword>")
    vim.api.nvim_command("!devdocs-desktop \"" .. word .. "\"")
end)

-- run generate-flash-card.sh and then paste clipboard content
vim.keymap.set("n", "<Leader>dS", function()
    vim.cmd("silent !generate-image2.sh")
    local status = vim.v.shell_error
    if status == 0 then
        -- delete word under cursor
        vim.cmd("normal! diW")

        -- paste clipboard content
        vim.cmd("normal! \"+p")
    else
        print("generate-image2.sh failed")
    end
end)

-- get uuid based on os.date
vim.keymap.set("n", "<Leader>zu", function()
    local uuid_format = "%Y%m%d%H%M"
    local uuid = os.date(uuid_format)
    vim.fn.setreg("+", uuid)
end)

-- cd into current file path
vim.keymap.set("n", "<Leader>z%", function()
    vim.cmd("!cd %:p:h")
end, { desc = "cd into current file path" })

-- Insert new line below/upper current line
vim.keymap.set("n", "]<space>", "moo<Esc>`o")
vim.keymap.set("n", "[<space>", "moO<Esc>`o")

-- run url_to_markdown_link.sh and then paste clipboard content
vim.keymap.set("n", "<Leader>pl", function()
    vim.cmd("silent !url_to_markdown_link.sh")
    local status = vim.v.shell_error
    if status == 0 then
        -- paste clipboard content
        vim.cmd("normal! \"+p")
    else
        print("url_to_markdown_link.sh failed")
    end
end, { desc = "Paste url as markdown link" })

-- run html2markdown.sh and then paste clipboard content
vim.keymap.set("n", "<Leader>ph", function()
    vim.cmd("silent !html2markdown.sh")
    local status = vim.v.shell_error
    if status == 0 then
        -- paste clipboard content
        vim.cmd("normal! \"+p")
    else
        print("html2markdown.sh failed")
    end
end, { desc = "Paste html as markdown" })

-- resize windows more quickly
vim.keymap.set("n", "<Leader>=", function()
    vim.cmd("exe \"resize \" . (winheight(0) * 3/2)")
end, { desc = "Resize window to 3/2" })

vim.keymap.set("n", "<Leader>-", function()
    vim.cmd("exe \"resize \" . (winheight(0) * 2/3)")
end, { desc = "Resize window to 2/3" })

vim.keymap.set("n", "<Leader>bd", ":bd<cr>", { desc = "Delete current buffer" })

-- close all buffers except current one
vim.keymap.set("n", "<Leader>bD", ":%bd|e#<cr>",
{ desc = "Close all buffers except current" })
