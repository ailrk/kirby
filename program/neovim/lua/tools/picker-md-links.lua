local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local conf = require("telescope.config").values


M.picker = function ()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  local results = {}
  for lnum, line in ipairs(lines) do
    local text, link = line:match("%[(.-)%]%((.-)%)")
    if link then
      table.insert(results, {
        lnum = lnum,
        text = text,
        link = link,
      })
    end
  end

  pickers.new({}, {
    prompt_title = "Markdown Links",
    finder = finders.new_table({
      results = results,
      entry_maker = function(entry)
        local cwd = vim.fn.expand("%:p:h")
        local path = vim.fs.normalize(vim.fs.joinpath(cwd, entry.link))

        return {
          value = entry,
          display = string.format("[%s](%s)", entry.text, entry.link),
          ordinal = entry.text .. " " .. entry.link,
          path = path,
          lnum = entry.lnum,
        }
      end,
    }),

    previewer = previewers.new_buffer_previewer({
      define_preview = function(self, entry)
        -- guard for missing file
        if not entry.path or vim.fn.filereadable(entry.path) ~= 1 then
          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {
            "Cannot preview link target:",
            entry.path or "nil",
          })
          return
        end

        -- load file into preview buffer
        local ft = vim.filetype.match({ filename = entry.path })
        if ft then vim.bo[self.state.bufnr].filetype = ft end
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.fn.readfile(entry.path))
      end,
    }),

    sorter = conf.generic_sorter({}),
  }):find()
end

return M
