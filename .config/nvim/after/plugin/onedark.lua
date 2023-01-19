require('onedark').setup {
    style = 'darker',
    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    transparent = true,
    code_style = {
        comments = 'none',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },
    -- redefine an existing color
    colors = {
        bg3 = "#4c324a",
        fg = "#b1b4b9",
        grey = "#646568",
    },
    -- fix ColorColumn transparency
    highlights = {
        ColorColumn = {bg = '#30363f'},
    }
}

require('onedark').load()
