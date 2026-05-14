require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "haskell",
    "c",
    "lua",
    "vim",
    "query",
    "markdown",
    "markdown_inline",
    "yaml",
    "nix",
    "toml",
    "html",
    "rust",
    "python"
  },
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true, -- fallback to default vim highlight
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['ab'] = '@block.outer',
        ['ib'] = '@block.inner',
      },
    },
  },
}


------------------------------
-- Highlight important functions


vim.treesitter.query.set(
  "haskell",
  "highlights",
  [[
    ((variable) @haskell.bold
     (#any-of? @haskell.bold
      "for_" "forM_" "for" "forM" "forConcurrently" "forConcurrently_" "mapConcurrently" "mapConcurrently_"
      "traverse" "mapM_" "mapM" "fmap" "map" "foldr" "foldl" "foldl'" "foldM"
      "<$>" "<|>" "<*>" "<&>" ">>=" ">>" "<<" "=<<"
      "throwIO" "throw" "throwSTM" "catchIO" "catch" "cathSTM" "try" "tryIO" "onException" "finally" "bracket" "bracket_"
      "newMVar" "newEmptyMVar" "takeMVar" "putMVar" "readMVar" "swapMVar" "tryTakeMVar" "tryPutMVar"
      "withMVar" "withMVarMasked" "modifyMVar_" "modifyMVar" "modifyMVarMasked_" "modifyMVarMasked"
      "mkWeakMVar" "addMVarFinializer"
      "newTVar" "newTVarIO" "readTVar" "readTVarIO" "writeTVar"
      "modifyTVar" "modifyTVar'" "stateTVar" "swapTVar" "registerTVar" "mkWeakTVar"
      "newTBQueue" "newTBQueueIO" "readTBQueue" "tryReadTBQueue" "flushTBQueue" "peekTBQueue" "tryPeekTBQueue"
      "writeTBQueue"
      "newTQueue" "newTQueueIO" "readTQueue" "tryReadTQueue" "flushTQueue" "peekTQueue" "tryPeekTQueue"
      "writeTQueue"
      "newIORef" "readIORef" "writeIORef" "modifyIORef" "modifyIORef'" "atomicModifyIORef" "atomicModifyIORef'"
      "atomicModifyIORef" "mkWeakIORef"
      "newSTRef" "readSTRef" "writeSTRef" "modifySTRef" "modifySTRef'"
    ))
  ]]
)


vim.api.nvim_set_hl(0, "@haskell.bold", { bold = true, link = "@keyword" })
