if PackerPluginLoaded("magma-nvim") then
    vim.cmd[[
    let g:magma_automatically_open_output = v:false
    let g:magma_image_provider = "kitty"
    ]]

    vim.api.nvim_set_keymap('n', '<Leader>r', ':MagmaEvaluateOperator<CR>', {silent = true, expr = true})
    vim.api.nvim_set_keymap('n', '<Leader>rr', ':MagmaEvaluateLine<CR>', {silent = true})
    vim.api.nvim_set_keymap('x', '<Leader>r', ':<C-u>MagmaEvaluateVisual<CR>', {silent = true})
    vim.api.nvim_set_keymap('n', '<Leader>rc', ':MagmaReevaluateCell<CR>', {silent = true})
    vim.api.nvim_set_keymap('n', '<Leader>rd', ':MagmaDelete<CR>', { silent = true})
    vim.api.nvim_set_keymap('n', '<Leader>ro', ':MagmaShowOutput<CR>', {silent = true})
end

