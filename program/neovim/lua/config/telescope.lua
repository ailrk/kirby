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
local builtin = require('telescope.builtin')


-- telescope-context.nvim
vim.keymap.set('n', '<space>cz', ':CtxLast<CR>', { desc = 'List locations in the last context' })
vim.keymap.set('n', '<space>cl', ':CtxLs ', { desc = 'List context/location' })
vim.keymap.set('n', '<space>ca', ':CtxAdd ', { desc = 'Add location to context' })
vim.keymap.set('n', '<space>cc', ':CtxCreate ', { desc = 'Create context' })

-- Using <space> as the prefix
vim.keymap.set('n', '<space>p', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<space>g', builtin.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<space>d', builtin.diagnostics, { desc = 'Diagnostics' })
vim.keymap.set('n', '<space>h', builtin.oldfiles, { desc = 'Old files (history)' })
vim.keymap.set('n', '<space>t', '<cmd>Telescope<cr>', { desc = 'Telescope builtin' })
vim.keymap.set('n', '<space>J', builtin.jumplist, { desc = 'Jumplist' })

-- Using <leader> as the prefix
vim.keymap.set('n', '<leader>c', builtin.commands, { desc = 'Commands' })
vim.keymap.set('n', '<leader>B', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>H', builtin.help_tags, { desc = 'Help tags' })
vim.keymap.set('n', '<leader>M', builtin.marks, { desc = 'Marks' })
vim.keymap.set('n', '<leader>R', builtin.registers, { desc = 'Registers' })
vim.keymap.set('n', '<leader>D', builtin.lsp_document_symbols, { desc = 'LSP Document Symbols' })
vim.keymap.set('n', '<leader>T', builtin.lsp_dynamic_workspace_symbols, { desc = 'LSP Workspace Symbols' })

-- Session Management
vim.keymap.set('n', '<space>s', '<cmd>SessionSearch<cr>', { desc = 'Session search' })
vim.keymap.set('n', '<C-s>', '<cmd>SessionSave<cr>', { desc = 'Session save' })

vim.keymap.set('n', '<space>fp', function()
    builtin.find_files({
        cwd = vim.fn.expand('%:p:h')
    })
end, { desc = 'Find files in current buffer dir' })
