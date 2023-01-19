local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'sumneko_lua',
    'rust_analyzer',
    'pylsp',
})

-- configure lua language server for neovim
-- see :help lsp-zero.nvim_workspace()
lsp.nvim_workspace()

-- Configure pyls
lsp.configure('pylsp', {
    settings = {
        plugins = {
            black = { enabled = true }
        }
    }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
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

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})

-- Custom DAP keybindings
local lspconfig = require('lspconfig')
local get_servers = require('mason-lspconfig').get_installed_servers

local lsp_attach = function(client, bufnr)
    -- Create your keybindings here...
    vim.keymap.set("n", "<Leader>dc", function() require 'dap'.continue() end)
    vim.keymap.set("n", "<Leader>di", function() require 'dap'.step_into() end)
    vim.keymap.set("n", "<Leader>do", function() require 'dap'.step_out() end)
    vim.keymap.set("n", "<Leader>dO", function() require 'dap'.step_over() end)
    vim.keymap.set("n", "<Leader>dr", function() require 'dap'.repl.open() end)
    vim.keymap.set("n", "<Leader>dl", function() require 'dap'.run_last() end)
    vim.keymap.set("n", "<Leader>db", function() require 'dap'.toggle_breakpoint() end)
    vim.keymap.set("n", "<Leader>dC", function() require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
    vim.keymap.set("n", "<Leader>dL",
        function() require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)

    -- Get file type
    local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')

    -- Python specific keybindings
    if ft == 'python' then
        vim.keymap.set("n", "<leader>dn", function() require('dap-python').test_method() end)
        vim.keymap.set("n", "<leader>df", function() require('dap-python').test_class() end)
        vim.keymap.set("n", "<leader>ds", function() require('dap-python').debug_selection() end)
    end
end

for _, server_name in ipairs(get_servers()) do
    lspconfig[server_name].setup({
        on_attach = lsp_attach,
    })
end
