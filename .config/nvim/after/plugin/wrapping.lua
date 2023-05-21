if PackerPluginLoaded("wrapping.nvim") then
    require("wrapping").setup({
        softener = {
            markdown = false,
        },
        auto_set_mode_filetype_allowlist = {
            "asciidoc",
            "gitcommit",
            "latex",
            "mail",
            "markdown",
            "rst",
            "tex",
            "text",
        },
    })

    -- -- Disable colorcolumn in markdown files
    -- local Wrapping_Disable_Color = vim.api.nvim_create_augroup("Wrapping_Disable_Color", {})
    --
    -- local autocmd = vim.api.nvim_create_autocmd
    -- autocmd("FileType", {
    --     group = Wrapping_Disable_Color,
    --     pattern = "markdown,gitcommit,mail,asciidoc,rst,tex,text",
    --     callback = function()
    --         vim.opt.colorcolumn = "0"
    --     end,
    -- })
end
