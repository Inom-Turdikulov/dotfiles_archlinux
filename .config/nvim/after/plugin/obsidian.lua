if PackerPluginLoaded("obsidian.nvim") then
    require("obsidian").setup {
        dir = "~/Projects/main/wiki", -- no need to call 'vim.fn.expand' here

        -- Optional, if you keep daily notes in a separate directory.
        daily_notes = {
            folder = "daily",
        },

        -- Optional, completion.
        completion = {
            nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
        },

        -- Optional, set to true if you don't want Obsidian to manage frontmatter.
        disable_frontmatter = true,

        -- Optional, for templates (see below).
        templates = {
            subdir = "templates",
            date_format = "%Y-%m-%d-%a",
            time_format = "%H:%M",
        },

        -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
        -- URL it will be ignored but you can customize this behavior here.
        follow_url_func = function(url)
            -- Open the URL in the default web browser.
            vim.fn.jobstart({ "xdg-open", url }) -- linux
        end,

        -- Optional, set to true if you use the Obsidian Advanced URI plugin.
        -- https://github.com/Vinzent03/obsidian-advanced-uri
        use_advanced_uri = true,

        -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
        open_app_foreground = true,
    }


    -- Open file in Obsidian vault
    vim.keymap.set("n", "<Leader>zo", function()
        vim.cmd("ObsidianOpen")
    end)
end
