-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Sort of lua framework
    use { 'nvim-lua/plenary.nvim' }

    -- File finder
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- A dark Vim/Neovim color scheme for the GUI and 16/256/true-color terminal
    use 'navarasu/onedark.nvim'

    -- Syntax Highlighiting
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/playground' }
    use {
        'ThePrimeagen/harpoon',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Undo tree
    use('mbbill/undotree')

    -- GIT
    use('tpope/vim-fugitive')

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    -- Distraction-free coding
    use("folke/zen-mode.nvim")

    -- OpenAI Codex to suggest code and entire functions
    use("github/copilot.vim")

    -- Fun and useless animations
    use("eandrju/cellular-automaton.nvim")

    -- Debugging
    use {
        'mfussenegger/nvim-dap-python',
        requires = { { 'mfussenegger/nvim-dap' } }
    }

    -- Local vimrc support
    use('klen/nvim-config-local')

    -- Editor config support
    use('gpanders/editorconfig.nvim')

    -- Telekasten - zettelkasten wiki
    use('renerocksai/telekasten.nvim')

    -- Better markdown support
    use('SidOfc/mkdx')
end)
