-- disable some builtin vim plugins
local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "rplugin",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(default_plugins) do
  vim.g["loaded_" .. plugin] = 1
end

local default_providers = {
  "node",
  "perl",
  "python3",
  "ruby",
}

for _, provider in ipairs(default_providers) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

return require('packer').startup(function(use)
    -- Plugin/package management for Neovim, packer can manage itself
    use 'wbthomason/packer.nvim'

    -- A dark Vim/Neovim color scheme for the GUI and 16/256/true-color terminal
    use 'navarasu/onedark.nvim'
    require('onedark').setup {
        style = 'darker',
        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
        code_style = {
            comments = 'none',
            keywords = 'none',
            functions = 'none',
            strings = 'none',
            variables = 'none'
        },
        -- redefine an existing color
        colors = {
            bg1 = "#2d3343",
            bg3 = "#2a324a",
            fg = "#b1b4b9",
            grey = "#646568",
        },
    }
    require('onedark').load()

    -- EditorConfig Vim Plugin
    use 'editorconfig/editorconfig-vim'

    -- Remove all background colors to make nvim transparent.
    use 'xiyaowong/nvim-transparent'
    require("transparent").setup({
      enable = true, -- boolean: enable transparent
    })

    -- Package manager
    -- manage external editor tooling such as LSP servers, DAP servers, linters, and formatter
    use {'williamboman/mason.nvim'}
    require("mason").setup()

    -- A blazing fast and easy to configure Neovim statusline written in Lua.
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }
    require('lualine').setup {
      options = {
        icons_enabled = true,
        section_separators = { left = '', right = ''},
        component_separators = { left = '|', right = '|'},
        theme = 'onedark',
      },
    }

    -- Library of 20+ independent Lua modules improving overall Neovim (version 0.6 and higher) experience with minimal effort. They all share same configuration approaches and general design principles.
	use({
		"echasnovski/mini.nvim", -- Align text interactively
		config = function()
			require("mini.align").setup()
			require("mini.comment").setup()
		end,
	})

    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    -- Autocomplete
    use {
         "hrsh7th/nvim-cmp",
          requires = {
             "hrsh7th/cmp-buffer",
             "hrsh7th/cmp-nvim-lsp",
             'hrsh7th/cmp-nvim-lua',
             'hrsh7th/cmp-path',
             'hrsh7th/cmp-cmdline',
             'L3MON4D3/LuaSnip',
             'saadparwaiz1/cmp_luasnip',
         }
     }
    -- Set up nvim-cmp. autocomplete
    vim.o.completeopt = "menu,menuone,noselect"
    local cmp = require'cmp'

    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local luasnip = require("luasnip")

    cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
   mapping = cmp.mapping.preset.insert({

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
    })

    -- Global capabilites used in LSP config
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- Configurations for Nvim LSP
    use 'neovim/nvim-lspconfig'
    -- confugure globl lsp config
    local nvim_lsp = require('lspconfig')
    local on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

      local opts = { noremap=true, silent=true }

      buf_set_keymap("n", "<leader>w=", "<cmd>lua vim.lsp.buf.formatting_sync(nil, 100)<CR>", opts)
      buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      buf_set_keymap('v', '<leader>wa', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      buf_set_keymap('n', '<leader>wd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
      buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      buf_set_keymap('n', '<leader>ww', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
      buf_set_keymap('n', '<leader>wW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
      buf_set_keymap('n', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
      buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
      buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    end
    -- Configure LSP servers
    local servers = {"clangd", "hls", "r_language_server", "racket_langserver", "clojure_lsp", "tsserver", "julials"}
    for _, lsp in ipairs(servers) do
      nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {debounce_text_changes = 150},
      }
    end

    nvim_lsp["pylsp"].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {debounce_text_changes = 150},
        settings = {
          pylsp = {
          configurationSources = {"pylint"},
          plugins = {
            pylint = { enabled = true },
            flake8 = { enabled = false },
            pycodestyle = { enabled = false },
            pyflakes = { enabled = false },
          }
        }
      }
    }

    use 'direnv/direnv.vim'
    use 'lewis6991/gitsigns.nvim'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "lua", "rust", "python", "markdown", "markdown_inline" },
    }

    use 'folke/which-key.nvim'
    require("which-key").setup {
        triggers = {"<leader>"},
    }

    -- use 'ggandor/leap.nvim'
    -- require('leap').add_default_mappings()

    use {"akinsho/toggleterm.nvim", tag = '*'}
    require("toggleterm").setup{ open_mapping = [[<c-\>]], }

    use {
      'TimUntersberger/neogit',
      requires = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim',
        'nvim-tree/nvim-web-devicons'
      }
    }

    use 'rickhowe/diffchar.vim'

    require('diffview').setup({
        use_icons = false
    })

    local neogit = require('neogit')
    neogit.setup {
      integrations = {
        -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
        -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
        --
        -- Requires you to have `sindrets/diffview.nvim` installed.
        --
        diffview = true
      },
    }

    use {'akinsho/git-conflict.nvim', tag = "*", config = function()
      require('git-conflict').setup()
    end}

    use 'nanotee/sqls.nvim'


    use  'renerocksai/telekasten.nvim'
    local wiki_home = vim.fn.expand("~/Projects/main/wiki/content/")
    require('telekasten').setup(
    {
        home = wiki_home,
        image_subdir = nil,
        plug_into_calendar = true,
        media_previewer = "viu-previewer",
        template_new_note =  wiki_home .. '/' .. 'templates/new_note.md',
        template_new_daily = wiki_home .. '/' .. 'templates/daily.md',
        template_new_weekly= wiki_home .. '/' .. 'templates/weekly.md',
        sort = "modified",
        auto_set_filetype = false,
        follow_url_fallback =  "call jobstart('zathura ~/Projects/main/wiki/content/{{url}}')"
    })

    use  'renerocksai/calendar-vim'

    use  'SidOfc/mkdx'
    vim.cmd [[
        let g:mkdx#settings     = { 'highlight': { 'enable': 0 },
                                \ 'enter': { 'shift': 1 },
                                \ 'map': { 'enable': 1 },
                                \ 'links': { 'external': { 'enable': 1 } },
                                \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                                \ 'fold': { 'enable': 1 },
                                \ 'table': { 'align': {
                                    \ 'left':    [],
                                    \ 'center':  [],
                                    \ 'right':   [],
                                    \ 'default': 'left' } } }
        let g:polyglot_disabled = ['markdown'] " for vim-polyglot users, it loads Plasticboy's markdown
   ]]

   -- highlight and search for todo comments like TODO, HACK, BUG
    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup {}
      end
    }

    use  'dkarter/bullets.vim'
    vim.cmd [[
        let g:bullets_enabled_file_types = [
            \ 'markdown',
            \ 'text',
            \ 'gitcommit',
            \ 'scratch',
            \ 'telekasten'
            \]
    ]]

    use 'gpanders/editorconfig.nvim'

    use  'nvim-lua/popup.nvim'

    use({
        "iamcco/markdown-preview.nvim",
        -- install without yarn or npm
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use { 'michaelb/sniprun', run = 'bash ./install.sh'}
    require'sniprun'.setup({
      interpreter_options = {         --# interpreter-specific options, see docs / :SnipInfo <name>

        --# use the interpreter name as key
        GFM_original = {
          use_on_filetypes = {"markdown.pandoc"}    --# the 'use_on_filetypes' configuration key is
                                                    --# available for every interpreter
        },
        Python3_original = {
            error_truncate = "auto"         --# Truncate runtime errors 'long', 'short' or 'auto'
                                            --# the hint is available for every interpreter
                                            --# but may not be always respected
        }
      },
    })

    -- Search
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- File browser with acticons support
    -- check mappings here - https://github.com/nvim-telescope/telescope.nvim#default-mappings
    use "nvim-telescope/telescope-file-browser.nvim"

    use { "nvim-telescope/telescope-bibtex.nvim",
      requires = {
        {'nvim-telescope/telescope.nvim'},
      },
      config = function ()
        require"telescope".load_extension("bibtex")
      end,
    }

    use 'nvim-telescope/telescope-media-files.nvim'
    use 'nvim-telescope/telescope-symbols.nvim'

    require('telescope').load_extension('media_files')
    require("telescope").load_extension('file_browser')
    require"telescope".load_extension("enhanced_find_files")

    local telescope = require("telescope")
    local trouble = require("trouble.providers.telescope")

    local bibtex_file = vim.fn.expand("~/Projects/main/wiki/books/library.bib")
    telescope.setup {
      extensions = {
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          filetypes = {"png", "webp", "jpg", "jpeg", "pdf"},
          find_cmd = "rg" -- find command (defaults to `fd`)
        },
        bibtex = {
          -- Use context awareness
          context = true,
          -- Use non-contextual behavior if no context found
          -- This setting has no effect if context = false
          context_fallback = true,
          global_files = {bibtex_file},
          citation_format = "[[^@{{label}}]]: {{author}} ({{year}}, {{month}} {{day}}). [{{title}}]({{file}}). {{publisher}}. {{url}}",
        },
        file_browser = {
          theme = "ivy",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            ["i"] = {
              -- your custom insert mode mappings
            },
            ["n"] = {
              -- your custom normal mode mappings
            },
          },
        },
      },
      defaults = {
        mappings = {
          i = { ["<c-t>"] = trouble.open_with_trouble },
          n = { ["<c-t>"] = trouble.open_with_trouble },
        },
      },
    }

    -- LSP trouble
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {
        }
      end
    }

    use 'simrat39/rust-tools.nvim'
    require('rust-tools').setup {
        tools = {
            autoSetHints = false,
            hover_with_actions = false,
            runnables = {use_telescope = false},
            inlay_hints = {
                parameter_hints_prefix = "» ",
                other_hints_prefix = "« "
            },
            hover_actions = {auto_focus = false}
        },
        server = {
          on_attach = on_attach,
          flags = {debounce_text_changes = 150}
        }
    }

    -- Debugging
    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-dap-python'
    local dap = require('dap')
    dap.adapters.cppdbg = {
      id = 'cppdbg',
      type = 'executable',
      command = '/opt/vscode-cpptools/debugAdapters/bin/OpenDebugAD7',
    }

    dap.configurations.c = {
      {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
        setupCommands = {
            {
                    text = '-enable-pretty-printing',
                    description =  'enable pretty printing',
                    ignoreFailures = false
            },
            },
      },
      {
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        setupCommands = {
            {
                    text = '-enable-pretty-printing',
                    description =  'enable pretty printing',
                    ignoreFailures = false
            },
            },
      },
    }
end)
