if PackerPluginLoaded("nvim-dap-vscode-js") then
    require("dap-vscode-js").setup({
        -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
        -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
        -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal',
            'pwa-extensionHost' }, -- which adapters to register in nvim-dap
        -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
        -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
        -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
    })

    for _, language in ipairs({ "javascript" }) do
        require("dap").configurations[language] = {
            {
                type = "pwa-chrome",
                request = "attach",
                name = "Attach to Chrome",
                port = 12039,
                -- urlFilter = "http://localhost:*",
                webRoot = "${workspaceFolder}",
            },
            {
                type = "chrome",
                request = "attach",
                name = "Attach to Chrome 2",
                port = 9222,
                urlFilter = "http://localhost:*",
                webRoot = "${workspaceFolder}",
            }
        }
    end
end

if PackerPluginLoaded("nvim-dap-python") then
    local pythonPath = function()
        -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
        -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
        -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
            return cwd .. '/venv/bin/python'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
            return cwd .. '/.venv/bin/python'
        else
            return '/usr/bin/python'
        end
    end

    vim.g.python3_host_prog = pythonPath()

    require('dap-python').setup(vim.g.python3_host_prog)
    require('dap-python').test_runner = 'pytest'
end
