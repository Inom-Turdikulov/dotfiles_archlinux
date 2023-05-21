if PackerPluginLoaded("cmp_luasnip") then
    local ls = require("luasnip")
    -- some shorthands...
    local snip = ls.snippet
    local node = ls.snippet_node
    local text = ls.text_node
    local insert = ls.insert_node
    local func = ls.function_node
    local choice = ls.choice_node
    local dynamicn = ls.dynamic_node

    -- Add TODO: snippet
    ls.add_snippets("all", {
        snip("TODO", {
            text("::TODO: "),
            insert(1, "ToDo text"),
            text(" ::"),
        }),
    })

    -- Load snippets from snippets directory
    -- ls.snippets_dir = vim.fn.stdpath("config") .. "/snippets"
    require("luasnip/loaders/from_vscode").load({
        paths = { "/home/inom/.config/nvim/snippets/" },
    })
end
