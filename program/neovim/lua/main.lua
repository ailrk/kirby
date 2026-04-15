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
      commit = '42fc28ba918343ebfd5565147a42a26580579482',
    }

    use {
      'nvim-treesitter/nvim-treesitter-textobjects',
      commit = '4e91b5d0394329a229725b021a8ea217099826ef',
    }

    use {'mtth/scratch.vim'}

    use {
      "selimacerbas/markdown-preview.nvim",
      requires = { "selimacerbas/live-server.nvim" },
      config = function()
        require("markdown_preview").setup({
          -- all optional; sane defaults shown
          port = 8421,
          open_browser = true,
          debounce_ms = 300,
        })
      end,
    }

    -- nvim
    use {'nvim-lua/plenary.nvim'}
    use {'nvim-telescope/telescope.nvim'}
    use {'nvim-telescope/telescope-ui-select.nvim'}
    use {'neovim/nvim-lsp'}
    use {'ailrk/telescope-context.nvim'}
    use {
      'rmagatti/auto-session',
      commit = '562fd8f398acb8b24cb1293a3b69fd2a4aa74e7b',
    }
    use {'folke/trouble.nvim'}
    use {'RishabhRD/popfix'}
    use {'RishabhRD/nvim-lsputils'}
    use {
      'echasnovski/mini.nvim',
      commit = 'a995fe9cd4193fb492b5df69175a351a74b3d36b',
    }

    -- color scheme
    use {'ailrk/vim-monochrome-waifu'}
    use {'kristijanhusak/vim-carbon-now-sh'}
end)


require("config.auto-session")
require("config.lsp")
require("config.mappings")
require("config.mini")
require("config.telescope")
require('config.theme')
require('config.image')
require("config.treesitter")

-- Setup command
vim.api.nvim_create_user_command("AuditOpen", require('tools.audit').audit_open, {})
vim.keymap.set("n", "<space>A", require('tools.audit').audit_open)


-- URI picker on floating window
vim.keymap.set("n", "<space>o", require('tools.picker-uri').picker, { desc = "Pick & open link from LSP hover" })


vim.keymap.set("n", "<space>ml", require('tools.picker-md-links').picker, { desc = "Markdown links" })


-- Message to Buffer
vim.api.nvim_create_user_command("LiveMessagesToggle", require('tools.live-messages').toggleLiveMessages, { desc = "Show :messages in a scratch buffer"})


vim.opt.tags = "./tags/tags;,tags/tags;,"
vim.opt.pumheight = 8
vim.o.winborder = 'rounded'
