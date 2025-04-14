-- https://github.com/wbthomason/packer.nvim#notices

-------------------------------------------------------------------
-- bootstrapping
local execute = vim.api.nvim_command
do
    local fn = vim.fn
    local install_path = fn.stdpath('data') ..
                             '/site/pack/packer/start/packer.nvim'

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
    use {'kien/rainbow_parentheses.vim'}
    use {'voldikss/vim-floaterm'}
    use {'christoomey/vim-system-copy'}
    use {'mtth/scratch.vim'}
    use {'junegunn/fzf.vim'}
    use {'honza/vim-snippets'}
    use {'SirVer/ultisnips'}
    use {'triglav/vim-visual-increment'}
    use {'preservim/nerdtree'}

    -- languages
    use {'deoplete-plugins/deoplete-lsp'}
    use {'PhilT/vim-fsharp'}
    use {'rhysd/vim-llvm'}
    use {'leafgarland/typescript-vim'}
    use {'peitalin/vim-jsx-typescript'}
    use {'lervag/vimtex'}
    use {'mattn/emmet-vim'}
    use {'purescript-contrib/purescript-vim'}
    use {'neovimhaskell/haskell-vim'}
    -- use {'psiska/telescope-hoogle.nvim'}
    use {'~/repo/telescope-hoogle.nvim'}
    use {'pangloss/vim-javascript'}
    use {'plasticboy/vim-markdown'}
    use {'justin2004/vim-apl'}
    use {'jez/vim-better-sml'}
    use {'Nymphium/vim-koka'}
    use {'https://github.com/LnL7/vim-nix'}
    use {'hashivim/vim-terraform'}
    use {'vmchale/just-vim'}
    use {'nvim-treesitter/nvim-treesitter'}
    use {'nvim-treesitter/nvim-treesitter-textobjects'}

    -- nvim
    use {'nvim-telescope/telescope.nvim'}
    use {'nvim-telescope/telescope-ui-select.nvim' }
    use {'rmagatti/auto-session'}
    use {'jpalardy/vim-slime'}
    use {'nvim-lua/plenary.nvim'}
    use {'neovim/nvim-lspconfig'}
    use {'neovim/nvim-lsp'}
    use {'RishabhRD/popfix'}
    use {'RishabhRD/nvim-lsputils'}
    use {'echasnovski/mini.nvim'}

    -- color scheme
    use {'ailrk/vim-monochrome-waifu'}
    use {'altercation/vim-colors-solarized'}
    use {'morhetz/gruvbox'}
    use {'pbrisbin/vim-colors-off'}
    use {'aunsira/macvim-light' }
    use {'kristijanhusak/vim-carbon-now-sh'}
end)


require("config.auto-session")
require("config.lsp")
require("config.mappings")
require("config.mini")
require("config.telescope")
require("config.treesitter")


-- URI picker on floating window
vim.keymap.set("n", "<space>o", require('tools.uri-picker').pick_links_from_float, { desc = "Pick & open link from LSP hover" })
