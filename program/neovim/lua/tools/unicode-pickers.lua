local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local entry_display = require('telescope.pickers.entry_display')
local conf = require('telescope.config').values

local UNICODES = {
    { symbol = '⊢', name = 'RIGHT TACK' },
    { symbol = '⊣', name = 'LEFT TACK' },
    { symbol = '⊤', name = 'DOWN TACK' },
    { symbol = '⊥', name = 'UP TACK' },
    { symbol = '⊧', name = 'MODELS' },
    { symbol = '⋮', name = 'VERTICAL ELLIPSIS' },
    { symbol = '⋯', name = 'MIDLINE HORIZONTAL ELLIPSIS' },
    { symbol = '⋰', name = 'UP RIGHT DIAGONAL ELLIPSIS' },
    { symbol = '⋱', name = 'DOWN RIGHT DIAGONAL ELLIPSIS' },
    { symbol = '→', name = 'RIGHTWARDS ARROW' },
    { symbol = '≡', name = 'IDENTICAL TO' },
    { symbol = '•', name = 'BULLET' },
    { symbol = 'Δ', name = 'GREEK CAPITAL LETTER DELTA' },
    { symbol = '∈', name = 'ELEMENT OF' },
    { symbol = '∉', name = 'NOT AN ELEMENT OF' },
    { symbol = '∋', name = 'CONTAINS AS MEMBER' },
    { symbol = '∌', name = 'DOES NOT CONTAIN AS MEMBER' },
    { symbol = '∎', name = 'END OF PROOF' },
    { symbol = '∏', name = 'N-ARY PRODUCT' },
    { symbol = '∐', name = 'N-ARY COPRODUCT' },
    { symbol = '∑', name = 'N-ARY SUMMATION' },
    { symbol = '∞', name = 'INFINITY' },
    { symbol = '∧', name = 'LOGICAL AND' },
    { symbol = '∨', name = 'LOGICAL OR' },
    { symbol = '∩', name = 'INTERSECTION' },
    { symbol = '∪', name = 'UNION' },
    { symbol = '∫', name = 'INTEGRAL' },
    { symbol = '∬', name = 'DOUBLE INTEGRAL' },
    { symbol = '∭', name = 'TRIPLE INTEGRAL' },
    { symbol = '∴', name = 'THEREFORE' },
    { symbol = '∵', name = 'BECAUSE' },
}

-- Opens a Telescope picker (search by English name) and inserts the
-- selected unicode character at the cursor in the current window.
local function insert_unicode()
  local mode = vim.api.nvim_get_mode().mode
  pickers.new({}, {
    prompt_title = "Insert Unicode",
    finder = finders.new_table {
      results = UNICODES,
      entry_maker = function(entry)
        return {
          value = entry,
          ordinal = entry.name,
          display = function(e)
            local displayer = entry_display.create({
              separator = ' ',
              items = { { width = 0.1 }, { width = 0.9 } },
            })
            return displayer({
              { e.value.symbol, 'TelescopeResultsIdentifier' },
              e.value.name,
            })
          end,
        }
      end
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then
          local buf = vim.api.nvim_get_current_buf()
          local row, col = unpack(vim.api.nvim_win_get_cursor(0))
          if mode ~= 'i' then col = col - 1 end
          local line = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1] or ''
          local symbol = selection.value.symbol
          vim.api.nvim_buf_set_lines(buf, row - 1, row, false,
            { line:sub(1, col) .. symbol .. line:sub(col + 1) })
          vim.api.nvim_win_set_cursor(0, { row, col + #symbol })
          if mode == 'i' then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('a', true, false, true), 'n', false)
          end
        end
      end)
      return true
    end,
  }):find()
end

vim.keymap.set({ 'i', 'n' }, '<C-k><C-k>', insert_unicode,
  { noremap = true, silent = true, desc = "Insert unicode symbol" })
