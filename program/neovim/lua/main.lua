-- https://github.com/wbthomason/packer.nvim#notices

-------------------------------
-- bootstrapping
local execute = vim.api.nvim_command
do
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system {
            'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
            install_path
        }
    end
end

execute 'packadd packer.nvim'


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
require('packer').startup(function(use)
    -- convenient
    use {'tpope/vim-fugitive'}
    use {'tpope/vim-commentary'}
    use {'voldikss/vim-floaterm'}
    use {'christoomey/vim-system-copy'}
    use {'junegunn/fzf.vim'}
    use {'honza/vim-snippets'}
    use {'SirVer/ultisnips'}
    use {'triglav/vim-visual-increment'}
    use {'preservim/nerdtree'}
    use {'godlygeek/tabular'}

    use {
        '3rd/image.nvim',
        commit = 'da2be65c153ba15a14a342b05591652a6df70d58'
    }

    -- languages
    use {'PhilT/vim-fsharp'}
    use {'leafgarland/typescript-vim'}
    use {'peitalin/vim-jsx-typescript'}
    use {'lervag/vimtex'}
    use {'mattn/emmet-vim'}
    use {'purescript-contrib/purescript-vim'}
    use {'neovimhaskell/haskell-vim'}
    use {'zoomlogo/vim-apl'}
    use {'junegunn/goyo.vim'}
    use {'plasticboy/vim-markdown'}
    use {'jez/vim-better-sml'}
    use {'https://github.com/LnL7/vim-nix'}
    use {'hashivim/vim-terraform'}
    use {'NoahTheDuke/vim-just'}

    use {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main', -- CRITICAL: Forces Packer to clone the main branch instead of master
    }

    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
    }

    use {'mtth/scratch.vim'}

    use {
        vim.fn.expand("$HOME/repo/live-preview.nvim"),
        config = function()
            require("live_preview").setup({
                port = 8421,
                open_browser = true,
                debounce_ms = 300,
                default_theme = "light"
            })
        end,
    }

    use {
        'ailrk/random-word-picker.nvim'
    }

    use {
        'oysandvik94/curl.nvim',
        config = function ()
            require"curl".setup()
        end
    }

    use {
        vim.fn.expand("$HOME/repo/excalidraw.nvim"),
    }


    use { 'ailrk/random-word-picker.nvim' }

    use {
        'hedyhli/outline.nvim',
        config = function()
            vim.keymap.set("n", "<space>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
            require("outline").setup {}
        end
    }

    use {
        'milanglacier/minuet-ai.nvim' ,
        config = function ()
            require('minuet').setup({
                provider = 'openai_compatible',
                provider_options = {
                    openai_compatible = {
                        model = 'copilot',
                        end_point = 'http://localhost:11435/v1/chat/completions',
                        name = 'LiteLLM',
                        api_key = 'TERM', -- dummy value, we don't need it
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
    }

    -- nvim
    use {'nvim-lua/plenary.nvim'}
    use {'nvim-telescope/telescope.nvim'}
    use {'nvim-telescope/telescope-ui-select.nvim'}
    use {'ailrk/telescope-context.nvim'}
    use {'neovim/nvim-lsp'}

    use {
        'rmagatti/auto-session',
        commit = '562fd8f398acb8b24cb1293a3b69fd2a4aa74e7b',
        config = function ()
            require("auto-session").setup {
                suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
                cwd_change_handling = true,
                pre_cwd_changed_cmds = {
                    "tabdo NERDTreeClose" -- Close NERDTree before saving session
                }
            }
        end
    }

    use {'folke/trouble.nvim'}
    use {'RishabhRD/popfix'}
    use {'RishabhRD/nvim-lsputils'}

    use {
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
    }

    use {
        'echasnovski/mini.nvim',
        commit = 'a995fe9cd4193fb492b5df69175a351a74b3d36b',
        config = function ()
            require('mini.completion').setup()
            local imap_expr = function(lhs, rhs)
                vim.keymap.set('i', lhs, rhs, { expr = true })
            end
            imap_expr('<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
            imap_expr('<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])
        end
    }

    use {
        'rafcamlet/nvim-luapad',
        commit = '918c60ae919d96df1dc201cbf69eb09090148cdd'
    }

    use {
        'brenoprata10/nvim-highlight-colors',
        config = function ()
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
    }

    -- color scheme
    use {'ailrk/vim-monochrome-waifu'}
    use {'kristijanhusak/vim-carbon-now-sh'}
end)


require("config.lsp")
require("config.mappings")
require("config.telescope")
require('config.theme')
require('config.image')
require("config.treesitter")

require("tools.picker-uri")
require("tools.picker-md-links")
require("tools.live-messages")
require("tools.unicode-pickers")
