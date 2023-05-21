if PackerPluginLoaded("telescope-bibtex.nvim") then
    vim.keymap.set("n", "<leader>fb", "<cmd>:Telescope bibtex<cr>")

    local bibtex_file = vim.fn.expand("~/Projects/main/wiki/books/library.bib")

    require("telescope").setup {
        extensions = {
            bibtex = {
                -- Use context awareness
                context = true,
                -- Use non-contextual behavior if no context found
                -- This setting has no effect if context = false
                context_fallback = true,
                global_files = { bibtex_file },
                citation_format =
                "[[^@{{label}}]]: {{author}} ({{year}}, {{month}} {{day}}). [{{title}}]({{file}}). {{publisher}}. {{url}}",
            },
        },
    }

    require("telescope").load_extension "bibtex"
end
