if PackerPluginLoaded("ChatGPT.nvim") then
    local OPENAI_API_KEY = vim.env.OPENAI_API_KEY

    if (OPENAI_API_KEY) then
        require("chatgpt").setup({
            welcome_message = "", -- set to "" if you don't like the fancy godot robot
            question_sign = "?", -- you can use emoji if you want e.g. 🙂
            answer_sign = ">", -- 🤖
            max_line_length = 120,
            yank_register = "+",
            chat_layout = {
                relative = "editor",
                position = "50%",
                size = {
                    height = "80%",
                    width = "80%",
                },
            },
            chat_input = {
                prompt = " : ",
                border = {
                    highlight = "FloatBorder",
                    style = "rounded",
                    text = {
                        top_align = "center",
                        top = " Prompt ",
                    },
                },
            },
            keymaps = {
                close = { "<C-c>", "<Esc>" },
                yank_last = "<C-y>",
                scroll_up = "<C-u>",
                scroll_down = "<C-d>",
                toggle_settings = "<C-o>",
                new_session = "<C-n>",
                cycle_windows = "<Tab>",
            },
        })

        vim.keymap.set("n", "<leader>G", ":ChatGPT<CR>", { silent = true })
    end
end

