-- Capture markdown links like this: [text](link)
-- If the link is a file in the current directory, preview will show
-- the file.
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
    local text, link = line:match("^[^!]*%[(.-)%]%((.-)%)")
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
        local path = nil
        if not entry.link:match("^https?://") then
          path = vim.fs.joinpath(cwd, entry.link)
          path = vim.fs.normalize(path)
        end
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
        local buf_lines
        if entry.path and vim.fn.filereadable(entry.path) == 1 then
          -- file eixsts
          buf_lines = vim.fn.readfile(entry.path)
          -- set filetype
          local ft = vim.filetype.match({ filename = entry.path })
          if ft then
            vim.bo[self.state.bufnr].filetype = ft
          end
        else
          -- fallback
          buf_lines = {
            "Cannot preview link target",
          }
        end
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, buf_lines)
      end,
    }),

    sorter = conf.generic_sorter({}),
  }):find()
end

return M
