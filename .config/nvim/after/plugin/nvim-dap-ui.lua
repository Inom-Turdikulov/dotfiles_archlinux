if PackerPluginLoaded("nvim-dap-ui") then
    require("dapui").setup()

    -- Automatically open dapui when dap is started
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    -- dap.listeners.before.event_terminated["dapui_config"]=function()
    --   dapui.close()
    -- end
    -- dap.listeners.before.event_exited["dapui_config"]=function()
    --   dapui.close()
    -- end

    -- Configure dap to use vscode-cpptools
    -- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(gdb-via--vscode-cpptools)
    local dap = require('dap')
    dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = 'OpenDebugAD7',
    }

    -- Lunch handmade executable debugging
    local dap_config = {
        {
            name = "Handmade Hero",
            type = "cppdbg",
            request = "launch",
            program = function()
                return vim.fn.expand(
                '~/Projects/main/handmadehero/build/linux_handmade')
            end,
            cwd = '${workspaceFolder}',
            stopAtEntry = true,
        },
        -- {
        --   name = 'Attach to gdbserver :1234',
        --   type = 'cppdbg',
        --   request = 'launch',
        --   MIMode = 'gdb',
        --   miDebuggerServerAddress = 'localhost:1234',
        --   miDebuggerPath = '/usr/bin/gdb',
        --   cwd = '${workspaceFolder}',
        --   program = function()
        --     return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        --   end,
        -- },
    }
    dap.configurations.cpp = dap_config
    dap.configurations.c = dap_config
end
