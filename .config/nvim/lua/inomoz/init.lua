require("inomoz.packer")
require("inomoz.set")
require("inomoz.remap")
require("inomoz.zathura")

local augroup = vim.api.nvim_create_augroup
local InomozGroup = augroup('Inomoz', {})
local InomozViewGroup = augroup('InomozView', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})


function R(name)
    require("plenary.reload").reload_module(name)
end

function PackerPluginLoaded(name)
    -- log plugin name
    if packer_plugins[name] and packer_plugins[name].loaded then
        return true
    else
        if vim.loop.os_uname().sysname == 'Linux' then
            print("WARNING: plugin " .. name .. " is not loaded")
        end

        return false
    end
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = InomozGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd({ "BufRead" }, {
    group = InomozViewGroup,
    pattern = "*",
    callback = function()
        vim.wo.listchars = GLOBAL_LISTCHARS
    end,
})

