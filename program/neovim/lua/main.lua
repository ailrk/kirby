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
require('packer').startup(function()
    use {'tpope/vim-fugitive'}

    -- convenient
    use {'junegunn/goyo.vim'}
    use {'tpope/vim-commentary'}
    use {'kien/rainbow_parentheses.vim'}
    use {'liuchengxu/vista.vim'}

    use {'vim-scripts/DrawIt'}
    use {'https://github.com/nathanaelkane/vim-indent-guides'}
    use {'voldikss/vim-floaterm'}
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
    -- use {'github/copilot.vim'}
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
    use {'triglav/vim-visual-increment'}

    use {'nvim-lua/completion-nvim'}
    use {'neovim/nvim-lspconfig'}
    use {'neovim/nvim-lsp'}
    use {'RishabhRD/popfix'}
    use {'RishabhRD/nvim-lsputils'}


    -- color scheme
    use {'ailrk/vim-monochrome-waifu'}
    use {'altercation/vim-colors-solarized'}
    use {'morhetz/gruvbox'}
    use {'pbrisbin/vim-colors-off'}
    use { 'aunsira/macvim-light' }
    use {'kristijanhusak/vim-carbon-now-sh'}

end)


-------------------------------------------------------------------
-- NVIM LSP
-- General nvim lsp config

-- Key bindings
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- autocmd
  vim.api.nvim_command [[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts) buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>df', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>ce', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[c', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']c', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>cq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap("n", "<space>l", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
  buf_set_keymap("n", "<space>cr", "<cmd>lua vim.lsp.codelens.refresh()<CR>", opts)
end


-- lean lsp
require'lspconfig'.leanls.setup{}
require('lean').setup{
  -- Enable the Lean language server(s)?
  --
  -- false to disable, otherwise should be a table of options to pass to
  --  `leanls` and/or `lean3ls`.
  --
  -- See https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#leanls for details.

  -- Lean 4
  lsp = { on_attach = on_attach },

  -- Lean 3
  -- lsp3 = { on_attach = on_attach },

  -- Abbreviation support
  abbreviations = {
    -- Set one of the following to true to enable abbreviations
    builtin = true, -- built-in expander
    compe = true, -- nvim-compe source
    snippets = false, -- snippets.nvim source
    -- additional abbreviations:
    extra = {
      -- Add a \wknight abbreviation to insert ♘
      --
      -- Note that the backslash is implied, and that you of
      -- course may also use a snippet engine directly to do
      -- this if so desired.
      wknight = '♘',
    },
    -- Change if you don't like the backslash
    -- (comma is a popular choice on French keyboards)
    leader = '\\',
  },

  -- Enable suggested mappings?
  --
  --
  -- false by default, true to enable
  mappings = true,

  -- Infoview support
  infoview = {
    -- Enable the infoview?
    enable = true,
    -- Automatically open an infoview on entering a Lean buffer?
    autoopen = true,
    -- Set the infoview windows' widths
    width = 50,
  },

  -- Progress bar support
  progress_bars = {
    -- Enable the progress bars?
    enable = true,
    -- Use a different priority for the signs
    priority = 10,
  },
}


-------------------------------------------------------------------
-- SETUP LSPS


-- haskell
require'lspconfig'.hls.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  },

  filetypes = {
    "hs",
    "lhs",
    "haskell"
  },

  -- TODO Note this is a chance for issue.
  settings = {
    haskell = {   -- TODO this is so weird. it's is found from the output
      formattingProvider = "stylish-haskell",
      hlintOn = false,
      maxNumberofProblems = 5,
      completionSnippetsOn = false,
      formatOnImportOn = true
    },
    -- languageServerHaskell = {
    --   formattingProvider = "stylish-haskell",
    -- }
  }
}

-- c/c++
require'lspconfig'.ccls.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  },

  init_options = {
    compilationDatabaseDirectory = "build",
    index = {
      threads = 0
    };
    clang = {
      excludeArgs = {"-frounding-math"},
      extraArgs = {"-std=c++2a" }
    };
  },
  filetypes = {
      "cpp", "objc", "objcpp"
  }
}


require'lspconfig'.clangd.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  },
  filetypes = {
    "c"
  }
}


-- ocaml
require'lspconfig'.ocamllsp.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  }
}


-- java

-- elm
require'lspconfig'.elmls.setup{
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    settings = {

    }
}

require'lspconfig'.purescriptls.setup{
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
}


-- racket
require'lspconfig'.racket_langserver.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  },
  cmd = { "racket", "--lib", "racket-langserver" }
}

-- lua
require'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- python
require'lspconfig'.pyright.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  }
}

-- rust
require'lspconfig'.rust_analyzer.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  },
  cmd = {"rust-analyzer"}
}


-- C#
local pid = vim.fn.getpid()
require'lspconfig'.omnisharp.setup{
  cmd = { omnisharp, "--languageserver", "--hostPID", tostring(pid) }
}

-- F#
require'lspconfig'.fsautocomplete.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  }
}

-- cmake
require'lspconfig'.cmake.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  }
}

require'lspconfig'.erlangls.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  }
}


-- typescript
require'lspconfig'.tsserver.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  }
}

-- viml
require'lspconfig'.vimls.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  }
}

-- cmake
require'lspconfig'.cmake.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  }
}

-- bash
require'lspconfig'.bashls.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  }
}

-------------------------------------------------------------------
-- NVIM auto completion compo
-- Compe setup
-- use {'hrsh7th/nvim-compe'}
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})


-------------------------------------------------------------------

vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler


-------------------------------------------------------------------
-- MAPPINGS

local function trim(s) return s:match '^%s*(.*%S)' or '' end

local function make_maps(mode, config)
    return function(maps)
        for _, v in ipairs(maps) do
            local from, to = unpack(v)
            vim.api.nvim_set_keymap(mode, trim(from), trim(to), config)
        end
    end
end

local normal_maps = make_maps('n', {noremap = true, silent = true})
local local_maps = make_maps('i', {noremap = true, silent = true})
local terminal_maps = make_maps('t', {noremap = true, silent = true})

-- general inop maps
local_maps {
    -- strings are trimed
    {[[ "         ]], [[ ""<left>      ]]},
    {[[ {         ]], [[ {}<left>      ]]},
    {[[ (         ]], [[ ()<left>      ]]},
    {[[ [         ]], [[ []<left>      ]]},
    {[[ {<CR>     ]], [[ {<CR>}<ESC>O  ]]},
    {[[ {;<CR>    ]], [[ {<CR>};<ESC>O ]]},
    {[[ <leader>; ]], [[ ::<left>      ]]},
    {[[ <leader>< ]], [[ <><left>      ]]},
    {[[ <leader>" ]], [[ "             ]]},
    {[[ <leader>L ]], [[ λ             ]]},
    {[[ <C-l>     ]], [[ <ESC>         ]]},
    {[[ <C-@>     ]], [[ <C-space>     ]]}
}


-- general inop maps
normal_maps {
    -- line number
    {[[ <leader>N     ]], [[ :set number!           ]]}, -- easy to config
    {[[ <leader>ev     ]], [[ :split $MYVIMRC<cr>    ]]},
    {[[ <leader>sv     ]], [[ :source $MYVIMRC<cr>   ]]}, -- coc.nvim extension
    {[[ <space>rt     ]], [[ :LspStop<cr>        ]]},
    {[[ <space>rs     ]], [[ :LspStart<cr>        ]]}, -- ad hoc formatter
    {[[ <leader>fm     ]], [[ :Format<cr>            ]]},


    -- remove trailing empty line
    {[[ <leader>rt     ]], [[ :RemoveTrailing<cr>    ]]},
    {[[ <space>qo     ]], [[ :call ToggleQuickFix(0)<cr>    ]]},
    {[[ <space>qO     ]], [[ :call ToggleQuickFix(1)<cr>    ]]},
}

terminal_maps {{'<Esc>', [[<C-\><C-n>]]}}

-----------------------------------------------------------------


