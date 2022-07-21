if require'conf'.debug then
  print("[lua] init plug")
end

-- https://github.com/wbthomason/packer.nvim#notices
-------------------------------------------------------------------
-- bootstrapping
local execute = vim.api.nvim_command
do
    local fn = vim.fn
    local install_path = fn.stdpath('data') ..
                             '/site/pack/packer/start/packer.nvim'

    if fn.empty(fn.glob(install_path)) > 0 then
        if require'conf'.debug then
          print("[lua] bootstrapping")
        end
        fn.system {
            'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
            install_path
        }
    end
end

execute 'packadd packer.nvim'

-------------------------------------------------------------------
-- TODO
require('packer').startup(function()
    use {'tpope/vim-fugitive'}

    -- big plugs
    -- use {'neoclide/coc.nvim', {branch = 'release'}}

    -- convenient
    use {'junegunn/goyo.vim'}
    use {'tpope/vim-commentary'}
    use {'kien/rainbow_parentheses.vim'}
    use {'liuchengxu/vista.vim'}

    -- use {'vimwiki/vimwiki'}
    use {'vim-scripts/DrawIt'}
    use {'https://github.com/nathanaelkane/vim-indent-guides'}
    use {'voldikss/vim-floaterm'}
    use {'xolox/vim-misc'}
    use {'xolox/vim-notes'}
    use {'christoomey/vim-system-copy'}
    use {'mtth/scratch.vim'}

    use {'jummy233/glyphs-vim'}
    use {'junegunn/fzf.vim'}

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
    use {'pangloss/vim-javascript'}
    use {'plasticboy/vim-markdown'}
    -- use {'leanprover/lean.vim'}
    use {'Julian/lean.nvim'}
    use {'justin2004/vim-apl'}
    use {'jez/vim-better-sml'}
    use {'Nymphium/vim-koka'}

    use {'whonore/Coqtail'}
    use {'kovisoft/slimv'}

--    use {'https://github.com/jez/vim-better-sml'}
--    use {'https://github.com/octol/vim-cpp-enhanced-highlight'}

    use {'https://github.com/LnL7/vim-nix'}
    use {'skywind3000/asyncrun.vim'}

    -- nvim
    use {'nvim-lua/popup.nvim'}
    use {'nvim-lua/plenary.nvim'}
    use {'nvim-telescope/telescope.nvim'}
    use {'hrsh7th/nvim-compe'}

    use {
      'rmagatti/auto-session',
      config = function()
        require('auto-session').setup {
          log_level = 'info',
          auto_session_suppress_dirs = {'~/', '~/Repo', '~/Projects'}
        }
      end
    }

    use {
      'rmagatti/session-lens',
      requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
      config = function()
        require('session-lens').setup({
            previewer = true
        })
      end
    }

    use {'diepm/vim-rest-console'}
    use {'preservim/nerdtree'}
    use {'jpalardy/vim-slime'}
    use {'roosta/vim-srcery'}
    use {'honza/vim-snippets'}
    use {'SirVer/ultisnips'}

    use {'nvim-lua/completion-nvim'}
    use {'neovim/nvim-lspconfig'}
    use {'neovim/nvim-lsp'}
    use {'RishabhRD/popfix'}
    use {'RishabhRD/nvim-lsputils'}


    -- color scheme
    use {'ailrk/vim-monochrome-waifu'}
    use {'altercation/vim-colors-solarized'}
    use {'morhetz/gruvbox'}
    use {'kristijanhusak/vim-carbon-now-sh'}
    use {'plan9-for-vimspace/acme-colors'}

end)
