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
    use {'justin2004/vim-apl'}
    use {'jez/vim-better-sml'}
    use {'Nymphium/vim-koka'}
    use {'kovisoft/slimv'}

    use {'https://github.com/LnL7/vim-nix'}
    use {'skywind3000/asyncrun.vim'}

    -- nvim
    use {'nvim-lua/popup.nvim'}
    use {'nvim-lua/plenary.nvim'}
    use {'nvim-telescope/telescope.nvim'}

    use {'preservim/nerdtree'}
    use {'jpalardy/vim-slime'}
    use {'honza/vim-snippets'}
    use {'SirVer/ultisnips'}
    use {'triglav/vim-visual-increment'}

    use {'nvim-lua/completion-nvim'}
    use {'neovim/nvim-lspconfig'}
    use {'neovim/nvim-lsp'}
    use {'RishabhRD/popfix'}
    use {'RishabhRD/nvim-lsputils'}


    -- color scheme
    use {'roosta/vim-srcery'}
    use {'ailrk/vim-monochrome-waifu'}
    use {'altercation/vim-colors-solarized'}
    use {'morhetz/gruvbox'}
    use {'pbrisbin/vim-colors-off'}
    use {'aunsira/macvim-light' }
    use {'kristijanhusak/vim-carbon-now-sh'}

    -- llm
    use { 'nomnivore/ollama.nvim' }
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
  buf_set_keymap('n', '[c', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']c', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>cq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap("n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap("n", "<space>l", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
  buf_set_keymap("n", "<space>cr", "<cmd>lua vim.lsp.codelens.refresh()<CR>", opts)
end



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

  settings = {
    haskell = {
      formattingProvider = "stylish-haskell",
      hlintOn = false,
      maxNumberofProblems = 5,
      completionSnippetsOn = false,
      formatOnImportOn = true
    },
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
require'lspconfig'.csharp_ls.setup{}


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
    {[[ <C-@>     ]], [[ <C-space>     ]]},
}


-- general inop maps
normal_maps {
    -- line number
    {[[ <leader>N  ]], [[ :set number!           ]]}, -- easy to config
    {[[ <leader>ev ]], [[ :split $MYVIMRC<cr>    ]]},
    {[[ <leader>sv ]], [[ :source $MYVIMRC<cr>   ]]}, -- coc.nvim extension

    {[[ <space>rt  ]], [[ :LspStop<cr>        ]]},
    {[[ <space>rs  ]], [[ :LspStart<cr>        ]]}, -- ad hoc formatter
    {[[ <leader>fm ]], [[ :Format<cr>            ]]},

    -- remove trailing empty line
    {[[ <leader>rt ]], [[ :RemoveTrailing<cr>    ]]},
    {[[ <space>qo  ]], [[ :call ToggleQuickFix(0)<cr>    ]]},
    {[[ <space>qO  ]], [[ :call ToggleQuickFix(1)<cr>    ]]},
}

terminal_maps {{'<Esc>', [[<C-\><C-n>]]}}
