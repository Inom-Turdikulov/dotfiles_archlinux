if PackerPluginLoaded("undotree") then
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
end
