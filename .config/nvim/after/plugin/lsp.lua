local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    "tsserver",
    "rust_analyzer",
    "pyright",
    "clangd",
    "ltex",
    -- from vscode-langservers-extracted
    "cssls",
    "eslint",
    "html",
    "jsonls",
    "efm",
})

require('lspconfig').gdscript.setup{
  debounce_text_changes = 150,
}

-- Configure pyls
-- lsp.configure('pylsp', {
--     settings = {
--         plugins = {
--             black = { enabled = true },
--         }
--     }
-- })


-- configure lua language server for neovim
-- see :help lsp-zero.nvim_workspace()
lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-d>'] = cmp.mapping.scroll_docs( -4),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    preselect = 'none',
    mapping = cmp_mappings,
    completion = {
        completeopt = 'menu,menuone,noinsert,noselect'
    },
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { unpack(opts), desc = 'LSP Go to Definition' })
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, { unpack(opts), desc = 'LSP Go to declaration' })
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end,
        { unpack(opts), desc = 'LSP Go to implementation' })
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { unpack(opts), desc = 'LSP Hover' })

    vim.keymap.set("n", "<leader>vws",
        function()
            vim.cmd("Telescope lsp_workspace_symbols")
        end,
        { unpack(opts), desc = 'Telescope LSP workspace symbol' }
    )

    vim.keymap.set("n", "<leader>vwS",
        function()
            vim.lsp.buf.workspace_symbol()
        end, { unpack(opts), desc = 'LSP Workspace Symbol' }
    )

    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end,
        { unpack(opts), desc = 'LSP Show Diagnostics' })
    vim.keymap.set("n", "<leader>F", function()
        vim.lsp.buf.format { async = true }
    end, { unpack(opts), desc = 'LSP Format' })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { unpack(opts), desc = 'LSP Go to Previous Diagnostic' })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { unpack(opts), desc = 'LSP Go to Next Diagnostic' })
    vim.keymap.set("n", "<leader>vaa", function() vim.lsp.buf.code_action() end,
        { unpack(opts), desc = 'LSP Code Action' })
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end,
        { unpack(opts), desc = 'LSP Go to References' })
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, { unpack(opts), desc = 'LSP Rename' })
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end,
        { unpack(opts), desc = 'LSP Signature Help' })

    -- if client.name == 'pyright' then
    --     -- optimize imports with pyright
    --     vim.keymap.set("n", "<leader>voi",
    --         function()
    --             vim.lsp.buf.execute_command({
    --                 command = 'pyright.organizeimports',
    --                 arguments = { vim.uri_from_bufnr(0) }
    --             })
    --         end, { unpack(opts), desc = 'LSP Organize Imports' })
    -- end

    -- Debugging
    vim.keymap.set("n", "<F5>", function() require 'dap'.continue() end, { desc = 'Debug continue' })
    vim.keymap.set("n", "<F6>", function() require 'dap'.pause.toggle() end, { desc = 'Debug pause toggle' })
    -- Custom restart session
    vim.keymap.set("n", "<leader>dR", function()
        require('dap').disconnect()
        require('dap').close()
        require('dap').run_last()
    end, { desc = 'debug restart' })
    vim.keymap.set("n", "<F9>", function() require 'dap'.toggle_breakpoint() end, { desc = 'Debug toggle breakpoint' })
    vim.keymap.set("n", "<S-F9>", function() require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
        { desc = 'Debug set breakpoint condition' })
    vim.keymap.set("n", "<C-F9>",
        function() require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
        { desc = 'Debug set log point' })
    vim.keymap.set("n", "<F10>", function() require 'dap'.step_over() end, { desc = 'Debug step over' })
    vim.keymap.set("n", "<F11>", function() require 'dap'.step_into() end, { desc = 'Debug step into' })
    vim.keymap.set("n", "<F12>", function() require 'dap'.step_out() end, { desc = 'Debug step out' })

    vim.keymap.set("n", "<Leader>dC", function() require 'dap'.run_to_cursor() end, { desc = 'Debug run to cursor' })
    vim.keymap.set("n", "<Leader>dI", function() require 'dap'.step_back() end, { desc = 'Debug next' })
    vim.keymap.set("n", "<Leader>dl", function() require 'dap'.repl.toggle() end, { desc = 'Debug repl toggle' })
    vim.keymap.set("n", "<leader>dr", function() require 'dap'.run_last() end, { desc = 'Debug run last' })

    vim.keymap.set("n", "<Leader>de", function() require 'dapui'.eval() end, { desc = 'Debug eval' })
    vim.keymap.set({ "n", "v" }, "<Leader>dh", function() require 'dap.ui.widgets'.hover() end, { desc = 'Debug hover' })
    vim.keymap.set({ "n", "v" }, "<Leader>dp", function() require 'dap.ui.widgets'.preview() end,
        { desc = 'Debug preview' })
    vim.keymap.set({ "n", "v" }, "<Leader>dF", function() require 'dap.ui.widgets'.frames() end,
        { desc = 'Debug frames' })
    vim.keymap.set({ "n", "v" }, "<Leader>ds", function() require 'dap.ui.widgets'.scopes() end,
        { desc = 'Debug scopes' })

    vim.keymap.set("n", "<Leader>dx", function() require 'dap'.close() end, { desc = 'Debug close' })
    vim.keymap.set("n", "<Leader>dX", function() require 'dap'.terminate() end, { desc = 'Debug terminate' })
    vim.keymap.set("n", "<Leader>dD", function() require 'dap'.disconnect() end, { desc = 'Debug disconnect' })


    -- Neotest keybindings
    vim.keymap.set("n", "<leader>dnn", function() require("neotest").run.run() end,
        { desc = 'Neotest run the nearest test' })
    vim.keymap.set("n", "<leader>dnc", function()
        require("neotest").run.run({ strategy = "dap" })
        require("neotest").summary.open()
    end,
        { desc = 'Neotest debug the nearest test' })

    vim.keymap.set("n", "<leader>dnf", function() require("neotest").run.run(vim.fn.expand("%")) end,
        { desc = 'Neotest run the current file' })

    vim.keymap.set("n", "<leader>dna", function() require("neotest").run.attach() end,
        { desc = 'Neotest attach to the nearest test' })
    vim.keymap.set("n", "<leader>dns", function() require("neotest").run.stop() end,
        { desc = 'Neotest stop the nearest test' })

    vim.keymap.set("n", "<leader>dno", function() require("neotest").output.open({ enter = true }) end,
        { desc = 'Neotest open the output of a test result' })

    vim.keymap.set("n", "<leader>dnt", function() require("neotest").output_panel.toggle() end,
        { desc = 'Neotest toggle the output panel' })

    vim.keymap.set("n", "<leader>dns", function()
        require("neotest").summary.open()
        require("functions.utils").resize_vertical_splits()
    end,
        { desc = 'Neotest open the summary window' })

    vim.keymap.set("n", "]n", function() require("neotest").jump.next() end, { desc = 'Neotest jump to the next test' })
    vim.keymap.set("n", "[n", function() require("neotest").jump.prev() end,
        { desc = 'Neotest jump to the previous test' })

    -- DapUI keybindings
    vim.keymap.set("n", "<Leader>dut", function() require('dapui').toggle() end, { desc = 'Debug ui toggle and reset' })
    vim.keymap.set("n", "<Leader>duc", function() require('dapui').close({ reset = true }) end,
        { desc = 'Debug ui close' })
    vim.keymap.set("n", "<Leader>duo", function() require('dapui').open({ reset = true }) end, { desc = 'Debug ui open' })

    if client.name == 'ltex' then
        -- Ltex config
        require("ltex_extra").setup {
            load_langs = { "ru-RU", "en-US" }, -- table <string> : languages for witch dictionaries will be loaded
            init_check = true, -- boolean : whether to load dictionaries on startup
            path = "~/.config/nvim/spell", -- string : path to store dictionaries. Relative path uses current working directory
            log_level = "none", -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
        }
    end
end)

local black = {
    formatCommand = "black --fast ${-l:lineLength} -",
    formatStdin = true,
}

local isort = {
    formatCommand = "isort --stdout ${-l:lineLength} --profile black -",
    formatStdin = true,
}

local flake8 = {
    lintCommand = "flake8 --max-line-length 120 --format '%(path)s:%(row)d:%(col)d: %(code)s %(code)s %(text)s' --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintIgnoreExitCode = true,
    lintFormats = { "%f:%l:%c: %t%n%n%n %m" },
    lintSource = "flake8",
}

local pycln = {
    formatCommand = "pycln -s -",
    formatStdin = true,
}

local mypy = {
    lintCommand = "mypy --show-column-numbers --ignore-missing-imports --show-error-codes",
    lintFormats = {
        "%f:%l:%c: %trror: %m",
        "%f:%l:%c: %tarning: %m",
        "%f:%l:%c: %tote: %m",
    },
    lintSource = "mypy",
}

local local_prettier = {
    formatCommand = [[$([ -n "$(command -v node_modules/.bin/prettier)" ] && echo "node_modules/.bin/prettier" || echo "prettier") --stdin-filepath ${INPUT} ${--config-precedence:configPrecedence} ${--tab-width:tabWidth} ${--single-quote:singleQuote} ${--trailing-comma:trailingComma}]],
    formatStdin = true,
}

local prettier = {
    formatCommand = 'prettierd "${INPUT}"',
    formatStdin = true,
    env = {
        string.format('PRETTIERD_DEFAULT_CONFIG=%s', vim.fn.expand('~/.config/nvim/linter-config/.prettierrc.json')),
    },
}

local eslint = {
    lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {
        "%f(%l,%c): %tarning %m",
        "%f(%l,%c): %rror %m",
    },
    lintSource = "eslint",
}

local cbfmt = {
    formatCommand = "cbfmt --best-effort --stdin-filepath ${INPUT}",
    formatStdin = true,
}

local languages = {
    python = { black, isort, flake8, mypy, pycln },
    typescript = { prettier, eslint },
    javascript = { prettier, eslint },
    typescriptreact = { prettier, eslint },
    javascriptreact = { prettier, eslint },
    yaml = { prettier },
    json = { prettier },
    html = { prettier },
    scss = { prettier },
    css = { prettier },
    markdown = { prettier },
}
lsp.configure('efm', {
    init_options = { documentFormatting = true },
    settings = {
        rootMarkers = { ".git/" },
        lintDebounce = 100,
        -- logLevel = 5,
        languages = languages,
    },
    filetypes = vim.tbl_keys(languages),
})

lsp.configure('pylsp', {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = { 'W391' },
                    maxLineLength = 100
                }
            }
        }
    }
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})

-- Set up black
-- vim.api.nvim_create_autocmd('FileType', {
--     desc = 'Format python on write using black',
--     pattern = 'python',
--     group = vim.api.nvim_create_augroup('black_on_save', { clear = true }),
--     callback = function(opts)
--         vim.api.nvim_create_autocmd('BufWritePre', {
--             buffer = opts.buf,
--             command = 'Black'
--         })
--     end,
-- })
