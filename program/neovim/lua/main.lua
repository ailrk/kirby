-- https://github.com/wbthomason/packer.nvim#notices

-------------------------------------------------------------------
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

-------------------------------------------------------------------
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

    -- languages
    use {'PhilT/vim-fsharp'}
    use {'leafgarland/typescript-vim'}
    use {'peitalin/vim-jsx-typescript'}
    use {'lervag/vimtex'}
    use {'mattn/emmet-vim'}
    use {'purescript-contrib/purescript-vim'}
    use {'neovimhaskell/haskell-vim'}
    use {'plasticboy/vim-markdown'}
    use {'jez/vim-better-sml'}
    use {'https://github.com/LnL7/vim-nix'}
    use {'hashivim/vim-terraform'}
    use {'NoahTheDuke/vim-just'}
    use {'nvim-treesitter/nvim-treesitter'}
    use {'nvim-treesitter/nvim-treesitter-textobjects'}

    -- nvim
    use {'nvim-telescope/telescope.nvim'}
    use {'nvim-telescope/telescope-ui-select.nvim' }
    use {'rmagatti/auto-session'}
    use {'nvim-lua/plenary.nvim'}
    use {'neovim/nvim-lspconfig'}
    use {'neovim/nvim-lsp'}
    use {'RishabhRD/popfix'}
    use {'RishabhRD/nvim-lsputils'}
    use {'echasnovski/mini.nvim'}

    -- color scheme
    use {'ailrk/vim-monochrome-waifu'}
    use {'morhetz/gruvbox'}
    use {'kristijanhusak/vim-carbon-now-sh'}
end)


require("config.auto-session")
require("config.lsp")
require("config.mappings")
require("config.mini")
require("config.telescope")
require('config.theme')
require("config.treesitter")


-- Setup command
vim.api.nvim_create_user_command("AuditOpen", require('tools.audit').audit_open, {})
vim.keymap.set("n", "<space>A", require('tools.audit').audit_open)


-- URI picker on floating window
vim.keymap.set("n", "<space>o", require('tools.uri-picker').pick_links_from_float, { desc = "Pick & open link from LSP hover" })


-- Message to Buffer
vim.api.nvim_create_user_command("LiveMessagesToggle", require('tools.live-messages').toggleLiveMessages, { desc = "Show :messages in a scratch buffer"})


-- theme
