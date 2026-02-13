-- telescope
-- This is your opts table
require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    },
  }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require"telescope".load_extension"ui-select"


-- telescope-context.nvim
vim.keymap.set('n', '<space>cz', ':CtxLast<CR>', { desc = 'List locations in the last context' })
vim.keymap.set('n', '<space>cl', ':CtxLs ', { desc = 'List context/location' })
vim.keymap.set('n', '<space>ca', ':CtxAdd ', { desc = 'Add location to context' })
vim.keymap.set('n', '<space>cc', ':CtxCreate ', { desc = 'Create context' })
