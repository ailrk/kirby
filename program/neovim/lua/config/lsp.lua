-------------------------------------------------------------------
-- NVIM LSP
-- General nvim lsp config

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local opts = { buffer = ev.buf, noremap = true, silent = true }

    -- Definitions & Navigation
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gn', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

    -- Workspace Folders
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    -- Refactoring & Actions
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action, opts)

    -- Diagnostics
    vim.keymap.set('n', '[c', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']c', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>cq', vim.diagnostic.setloclist, opts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)

    -- Codelens
    vim.keymap.set("n", "<space>l", vim.lsp.codelens.run, opts)
    vim.keymap.set("n", "<space>cr", vim.lsp.codelens.refresh, opts)
  end,
})

-- Haskell
vim.lsp.config('hls', {
  filetypes = { "hs", "lhs", "haskell" },
  settings = {
    haskell = {
      formattingProvider = "stylish-haskell",
      hlintOn = false,
      maxNumberofProblems = 5,
      completionSnippetsOn = false,
      formatOnImportOn = true,
      plugin = {
        tactics = { globalOn = false },
        refactor = { globalOn = false },
        stan = { globalOn = false },
        hlint = { codeActionsOn = false },
        retrie = { globalOn = false },
        ['ghcide-code-actions-bindings'] = { globalOn = false },
        ['ghcide-code-actions-fill-holes'] = { globalOn = false }
      }
    },
  }
})

-- Rust
vim.lsp.config('rust_analyzer', {
  cmd = {"rust-analyzer"},
  settings = {
    ['rust-analyzer'] = {
      check = { ignore = { "dead_code" } }
    }
  }
})

-- Nix
vim.lsp.config('nixd', {
  cmd = { 'nixd' },
  settings = {
    nixd = { nixpkgs = { expr = "import <nixpkgs> {}" } }
  }
})

-- Racket
vim.lsp.config('racket_langserver', {
  cmd = { "racket", "--lib", "racket-langserver" }
})

-- Lua (Preserving your dynamic workspace logic)
vim.lsp.config('lua_ls', {
  on_init = function(client)
    local path = client.workspace_folders and client.workspace_folders[1].name
    if path and (vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc')) then
      return
    end
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = { version = 'LuaJIT' },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME, "${3rd}/luv/library", "${3rd}/busted/library" }
      }
    })
  end,
  settings = { Lua = {} }
})

-- Lean4
vim.lsp.config('lean4', {
  cmd = { 'lean', '--server' },
  root_dir = vim.fs.root(0, {"lean-toolchain", "lakefile.lean", ".git"}),
  filetypes = { 'lean' },
})

-- 4. Enable All Servers
-- List every server you use here. If no config was defined above,
-- it will use Neovim's internal defaults.
vim.lsp.enable({
  'hls',
  'clangd',
  'nixd',
  'ocamllsp',
  'elmls',
  'purescriptls',
  'racket_langserver',
  'lua_ls',
  'pyright',
  'rust_analyzer',
  'csharp_ls',
  'fsautocomplete',
  'cmake',
  'erlangls',
  'ts_ls',
  'vimls',
  'bashls',
  'lean4'
})
