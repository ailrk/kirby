-------------------------------------------------------------------
-- NVIM LSP
-- General nvim lsp config

-- Key bindings
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local lspconfig = require'lspconfig'
local configs = require 'lspconfig.configs'

local function on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc') -- <c-x><c-o>
  local opts = { noremap=true, silent=true }           -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gn', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts) buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '[c', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']c', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>cq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap("n", "<space>l", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
  buf_set_keymap("n", "<space>cr", "<cmd>lua vim.lsp.codelens.refresh()<CR>", opts)
end


lspconfig.hls.setup{
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


lspconfig.clangd.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  },
  filetypes = {
    "c", "cpp", "objc", "objcpp"
  }
}


-- nix
lspconfig.nixd.setup{
  cmd = { 'nixd' },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> {}",
      },
    }
  }
}


-- ocaml
lspconfig.ocamllsp.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  }
}


-- elm
lspconfig.elmls.setup{
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    settings = {

    }
}


lspconfig.purescriptls.setup{
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
}


-- racket
lspconfig.racket_langserver.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  },
  cmd = { "racket", "--lib", "racket-langserver" }
}


-- lua
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
          "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,

  settings = {
    Lua = {}
  }
}


-- python
lspconfig.pyright.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  },
}


-- rust
lspconfig.rust_analyzer.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  },
  cmd = {"rust-analyzer"},
  settings = {
    ['rust-analyzer'] = {
        check = {
            ignore = { "dead_code" }
        }
    },
  },
}


-- C#
lspconfig.csharp_ls.setup{}


-- F#
lspconfig.fsautocomplete.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  }
}


-- cmake
lspconfig.cmake.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  }
}


-- erlang
lspconfig.erlangls.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  }
}


-- typescript
lspconfig.ts_ls.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  }
}


-- viml
lspconfig.vimls.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  }
}


-- cmake
lspconfig.cmake.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  }
}


-- bash
lspconfig.bashls.setup{
  on_attach = on_attach,
  flags = {
      debounce_text_changes = 150,
  }
}




if not configs.lean4 then
  configs.lean4 = {
    default_config = {
      name = 'lean4',
      cmd = { 'lean', '--server' },
      root_dir = lspconfig.util.root_pattern("lean-toolchain", "lakefile.lean", ".git"),
      filetypes = { 'lean' },
    },
  }
end
lspconfig.lean4.setup {
  on_attach = on_attach,
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
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })


-- Set border for diagnostic float
vim.diagnostic.config({
  float = {
    border = "rounded",
  },
})

return {}
