-------------------------------
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-------------------------------
-- Vim
vim.opt.tags = "./tags/tags;,tags/tags;,"
vim.opt.pumheight = 8
vim.opt.formatoptions:append("m")
vim.opt.foldmethod = "expr"                             -- Tell Neovim to use an expression to calculate folds
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"    -- Use Neovim's built-in Treesitter fold expression
vim.opt.foldlevelstart = 99                             -- Prevent all folds from closing automatically when opening a file
vim.opt.termguicolors = true
vim.o.winborder = 'rounded'

vim.opt.title = true
vim.opt.titlestring = "%{expand('%:t')}%( %m%)"         -- Show editing state on title

vim.filetype.add({
    pattern = {
        -- Match any file ending with .dump-simpl, .dump-stg, etc.
        [".*%.dump%-simpl.*"] = "haskell",
        [".*%.dump%-stg.*"] = "haskell",
        [".*%.dump%-cmm.*"] = "haskell",
        [".*%.dump%-asm.*"] = "asm",
    },
})

-------------------------------
-- PLUGINS
require("lazy").setup({
    -- Convenient
    { 'tpope/vim-commentary' },
    { 'voldikss/vim-floaterm' },
    { 'christoomey/vim-system-copy' },
    { 'junegunn/fzf.vim' },
    { 'triglav/vim-visual-increment' },
    { 'preservim/nerdtree' },
    { 'godlygeek/tabular' },
    { 'L3MON4D3/LuaSnip',
        version = "v2.*",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            local ls = require("luasnip")

            ls.setup({
                history = false,
                enable_autosnippets = true,
            })

            -- friendly-snippets (VSCode format)
            require("luasnip.loaders.from_vscode").lazy_load()
            -- custom snippets, one file per filetype, e.g. snippets/haskell.lua
            require("luasnip.loaders.from_lua").lazy_load({
                paths = vim.fn.stdpath("config") .. "/snippets",
            })

            vim.keymap.set({ "i", "s" }, "<C-j>", function() ls.expand_or_jump() end, { silent = true })
        end,
    },

    -- Languages
    { 'leafgarland/typescript-vim' },
    { 'peitalin/vim-jsx-typescript' },
    { 'lervag/vimtex' },
    { 'mattn/emmet-vim' },
    { 'purescript-contrib/purescript-vim' },
    { 'junegunn/goyo.vim' },
    { 'LnL7/vim-nix' },
    { 'hashivim/vim-terraform' },
    { 'NoahTheDuke/vim-just' },
    { 'neovimhaskell/haskell-vim' },

    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
    },

    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
    },

    { 'mtth/scratch.vim' },

    {
        dir = vim.fn.expand("$HOME/repo/live-preview.nvim"),
        config = function()
            require("live_preview").setup({
                open_browser = true,
                debounce_ms = 100,
                extra_asset_roots = {
                    vim.fn.expand("$HOME/repo/note"),
                    vim.fn.expand("$HOME/note")
                },
                default_theme = "light"
            })
        end,
    },

    {
        dir = vim.fn.expand("$HOME/repo/printlog.nvim"),
        config = function()
            require("printlog").setup()
        end
    },

    {
        'oysandvik94/curl.nvim',
        config = function()
            require("curl").setup()
        end
    },

    {
        dir = vim.fn.expand("$HOME/repo/excalidraw.nvim"),
    },

    { 'ailrk/random-word-picker.nvim' },

    {
        'hedyhli/outline.nvim',
        config = function()
            vim.keymap.set("n", "<space>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
            require("outline").setup({})
        end
    },

    {
        'milanglacier/minuet-ai.nvim',
        config = function()
            require('minuet').setup({
                provider = 'openai_compatible',
                provider_options = {
                    openai_compatible = {
                        model = 'copilot',
                        end_point = 'http://localhost:11435/v1/chat/completions',
                        name = 'LiteLLM',
                        api_key = 'TERM',
                        stream = true,
                        optional = {
                            max_tokens = 512,
                            stop = { "\n\n" },
                        }
                    }
                },
                virtualtext = {
                    auto_trigger_ft = {},
                    keymap = {
                        accept = '<A-A>',
                        accept_line = '<A-a>',
                        accept_n_lines = '<A-z>',
                        prev = '<A-[>',
                        next = '<A-]>',
                        dismiss = '<A-e>',
                    },
                }
            })
        end
    },

    -- Nvim
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'neovim/nvim-lspconfig' }, -- Note: renamed from nvim-lsp to standard nvim-lspconfig if applicable

    {
        'rmagatti/auto-session',
        commit = '562fd8f398acb8b24cb1293a3b69fd2a4aa74e7b',
        config = function()
            require("auto-session").setup({
                suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
                cwd_change_handling = true,
                pre_cwd_changed_cmds = {
                    "tabdo NERDTreeClose"
                }
            })
        end
    },

    { 'folke/trouble.nvim' },
    { 'RishabhRD/popfix' },
    { 'RishabhRD/nvim-lsputils' },

    {
        'kelly-lin/ranger.nvim',
        config = function()
            require("ranger-nvim").setup({ replace_netrw = true })
            vim.api.nvim_set_keymap("n", "<leader>ef", "", {
                noremap = true,
                callback = function()
                    require("ranger-nvim").open(true)
                end,
            })
        end,
    },

    {
        'echasnovski/mini.nvim',
        commit = 'a995fe9cd4193fb492b5df69175a351a74b3d36b',
        config = function()
            require('mini.completion').setup()
            local imap_expr = function(lhs, rhs)
                vim.keymap.set('i', lhs, rhs, { expr = true })
            end
            imap_expr('<Tab>',    [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
            imap_expr('<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])
        end
    },

    {
        'rafcamlet/nvim-luapad',
        commit = '918c60ae919d96df1dc201cbf69eb09090148cdd'
    },

    {
        'brenoprata10/nvim-highlight-colors',
        config = function()
            require('nvim-highlight-colors').setup({
                render = 'background',
                enable_hex = true,
                enable_short_hex = true,
                enable_rgb = true,
                enable_hsl = true,
                enable_ansi = true,
                enable_xterm256 = true,
            })
        end
    },

    -- Color scheme
    { 'ailrk/vim-monochrome-waifu' },
})

require("config.lsp")
require("config.mappings")
require("config.telescope")
require('config.theme')
require("config.treesitter")
require("config.tabline")
require("config.indent")

require("tools.picker-uri")
require("tools.picker-md-links")
require("tools.live-messages")
require("tools.unicode-pickers")
require("tools.gitpick").setup()
