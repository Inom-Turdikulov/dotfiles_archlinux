-- Mappings
function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

nmap("<Leader>oc", ": !gcc % && ./a.out <CR>")
nmap("<Leader>ov", ': !$TERMINAL -e visidata "%"<CR>')

nmap("<Leader>dc", "<Cmd>lua require'dap'.continue()<CR>")
nmap("<Leader>di", "<Cmd>lua require'dap'.step_into()<CR>")
nmap("<Leader>do", "<Cmd>lua require'dap'.step_out()<CR>")
nmap("<Leader>dO", "<Cmd>lua require'dap'.step_over()<CR>")
nmap("<Leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>")
nmap("<Leader>dl", "<Cmd>lua require'dap'.run_last()<CR>")
nmap("<Leader>db", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>")
nmap("<Leader>dC", "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
nmap("<Leader>dL", "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
nmap("<leader>dn", "<cmd>:lua require('dap-python').test_method()<CR>")
nmap("<leader>df", "<cmd>:lua require('dap-python').test_class()<CR>")
vmap("<leader>ds", "<ESC>:lua require('dap-python').debug_selection()<CR>")

nmap("<leader>gg", "<cmd>Neogit<cr>")
nmap("<leader>gc", "<cmd>Neogit commit<cr>")
nmap("<leader>zz", ":call OpenZathura()<cr>")
nmap("<leader>fF", "<cmd>Telescope find_files<cr>")
nmap("<leader>ff", "<cmd>Telescope enhanced_find_files<cr>")
nmap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nmap("<leader>fb", "<cmd>Telescope buffers<cr>")
nmap("<leader>fh", "<cmd>Telescope help_tags<cr>")
nmap("<leader>fb", "<cmd>Telescope file_browser<cr>")
nmap("<leader>fB", "<cmd>Telescope bibtex<cr>")
vmap("<leader>F", "<cmd>lua vim.lsp.buf.range_formatting()<CR>")

nmap("<leader>zn", "<Cmd>lua require('telekasten').new_note()<CR>")
nmap("<leader>zN", "<Cmd>:lua require('telekasten').new_templated_note()<CR>")

nmap("<leader>zf", "<Cmd>lua require('telekasten').find_notes()<CR>")
nmap("<leader>zF", "<Cmd>lua require('telekasten').follow_link()<CR>")

nmap("<leader>zd", "<Cmd>lua require('telekasten').find_daily_notes()<CR>")
nmap("<leader>zw", "<Cmd>:lua require('telekasten').find_weekly_notes()<CR>")
nmap("<leader>zT", "<Cmd>:lua require('telekasten').goto_today()<CR>")
nmap("<leader>zW", "<Cmd>:lua require('telekasten').goto_thisweek()<CR>")

nmap("<leader>zg", "<Cmd>lua require('telekasten').search_notes()<CR>")

nmap("<leader>zy", "<Cmd>:lua require('telekasten').yank_notelink()<CR>")
nmap("<leader>zc", "<Cmd>:lua require('telekasten').show_calendar()<CR>")
nmap("<leader>zC", "<Cmd>:CalendarT<CR>")

nmap("<leader>zi", "<Cmd>:lua require('telekasten').paste_img_and_link()<CR>")
nmap("<leader>zt", "<Cmd>:lua require('telekasten').toggle_todo()<CR>")
nmap("<leader>zb", "<Cmd>:lua require('telekasten').show_backlinks()<CR>")
nmap("<leader>zF", "<Cmd>:lua require('telekasten').find_friends()<CR>")
nmap("<leader>zI", "<Cmd>:lua require('telekasten').insert_img_link({ i=true })<CR>")
nmap("<leader>zp", "<Cmd>:lua require('telekasten').preview_img()<CR>")
nmap("<leader>zm", "<Cmd>:lua require('telekasten').browse_media()<CR>")
nmap("<leader>za", "<Cmd>:lua require('telekasten').show_tags()<CR>")
nmap("<leader>#", "<Cmd>:lua require('telekasten').show_tags()<CR>")
nmap("<leader>zr", "<Cmd>:lua require('telekasten').rename_note()<CR>")

nmap("<leader>c", "<Cmd>:lua require'sniprun'.run()<CR>")
vmap("<leader>c", "<cmd>:lua require'sniprun'.run('v')<CR>")
nmap("<leader>C", "{)|<Cmd>:lua require'sniprun'.run()<CR>")

-- on hesitation, bring up the panel
nmap("<leader>z", "<Cmd>:lua require('telekasten').panel()<CR>")

-- we could define [[ in **insert mode** to call insert link
-- inoremap [[ <cmd>:lua require('telekasten').insert_link()<CR>
-- alternatively: leader [

-- imap("C-[", "<cmd>:lua require('telekasten').insert_link({ i=true })<CR>")
-- imap("C-z t", "<cmd>:lua require('telekasten').toggle_todo({ i=true })<CR>")
-- imap("C-#", "<cmd>lua require('telekasten').show_tags({i = true})<cr>")

-- Run the nearest test
nmap("<leader>dt", "<cwd>lua require'neotest'.run.run())")


-- Prettier
nmap("<leader>pd", ": !prettier --parser=".. vim.bo.filetype .. " -w '%'<CR>")

-- Save
imap("<C-s>", "<C-O>:w<CR>")
nmap("<C-s>", ":w<CR>")
vmap("<C-s>", ":w<CR>")

--[[ Run the current file

require("neotest").run.run(vim.fn.expand("%"))
Debug the nearest test (requires nvim-dap and adapter support)

require("neotest").run.run({strategy = "dap"})
See :h neotest.run.run() for parameters.

Stop the nearest test, see :h neotest.run.stop()

require("neotest").run.stop()
Attach to the nearest test, see :h neotest.run.attach()

require("neotest").run.attach() ]]
