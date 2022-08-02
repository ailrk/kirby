if require'conf'.debug then
  print("[lua] init plug configurations")
end

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, "r"))
  local s = assert(f:read("*a"))
  f:close()
  if raw then return s end
  s = string.gsub(s, "^%s+", "")
  s = string.gsub(s, "%s+$", "")
  s = string.gsub(s, "[\n\r]+", " ")
  return s
end

function file_exists(name)
  local f = io.open(name, "r")
  return f ~= nil and io.close(f)
end

-------------------------------------------------------------------
-- NVIM LSP
----------------------------
-- General nvim lsp config

----------------------------
-- Key bindings
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
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

-------------------------------------------------------------------
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
-- setup lsps


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
do
  local system_name
  if vim.fn.has("mac") == 1 then system_name = "macOS"
  elseif vim.fn.has("unix") == 1 then system_name = "Linux"
  elseif vim.fn.has("win32") == 1 then system_name = "Windows"
  else
    print("[err] Unsupported system for sumneko")  -- bottom
    goto lualsp_end
  end

  local sumneko_root_path = vim.fn.stdpath('cache') .. '/lua-language-server'
  if sumneko_root_path == nil  then
    print("[err] with sumneko_root_path: " .. sumneko_root_path)
    goto lualsp_end
  end

  local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"
  if sumneko_root_path == nil then
    print("err with sumneko_binary: " .. sumneko_binary)
    goto lualsp_end
  end

  -- install to $HOME/.cache/nvim if it's not already there.
  if not file_exists(sumneko_root_path) then
    print("Sumneko is not installed, installing now...")

    os.execute([[
      cd $HOME/.cache/nvim &&
      git clone https://github.com/sumneko/lua-language-server &&
      cd lua-language-server &&
      git submodule update --init --recursive
    ]])

    if not(file_exists(sumneko_root_path) or file_exists(sumneko_binary)) then
      os.execute("rm -rf $HOME/.cache/nvim/lua-language_server")
      goto lualsp_end
    end

    print("lua-langauge-server is downloaded.")
    print("$ cd $HOME/.cache/nvim/lua-language-server/3rd/luamake $$ ./compile/install.sh && cd ../.. && 3rd/luamake/luamake rebuild")
  end

  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
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

:: lualsp_end ::
end


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
-- Plug 'RishabhRD/popfix'
-- Plug 'RishabhRD/nvim-lsputils'

vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler


-------------------------------------------------------------------
-- tree sitter
--
require 'nvim-treesitter.install'.compilers = { "clang" }
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
      "c", "lua", "rust", "haskell", "cpp", "elixir", "ocaml", "elm", "bash", "dot", "erlang", "nix",
      "json", "llvm", "make", "ruby", "python", "scala", "latex", "make", "sql", "typescript", "vim", "scheme" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {
  },

incremental_selection = { enable = true },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {
        "markdown",
        "c",
        "toml",
        "rust",
        "nix",
        "bash",
        "make",
        "vim"
    },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
