local M = {}

-- Function to pick and open links from the floating window
M.picker = function()
  -- Get the current buffer's content
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  local links = {}
  local seen = {}

  -- Extract markdown-style links and protocol-based links
  for _, line in ipairs(lines) do
    -- Extract markdown links [Text](URL)
    for text, url in line:gmatch("%[(.-)%]%((%a+://[%a%d/.:#-]+)%)") do
      if not seen[url] then
        table.insert(links, { text = text, url = url })
        seen[url] = true
      end
    end
    -- Extract plain protocol links (http://, https://, file://)
    for url in line:gmatch("(%a+://[%a%d/.:#-]+)") do
      if not seen[url] then
        table.insert(links, { text = url, url = url })  -- Use the URL as the fallback text
        seen[url] = true
      end
    end
  end

  if vim.tbl_isempty(links) then
    print("No links found in the buffer")
    return
  end

  -- Telescope picker to choose a link
  require("telescope.pickers").new({}, {
    prompt_title = "Select a Link to Open",
    finder = require("telescope.finders").new_table {
      results = vim.tbl_map(function(entry)
        return entry.text  -- Display the text of the link in the picker
      end, links),
    },
    sorter = require("telescope.config").values.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")


      local opener = vim.fn.has("mac") == 1 and "open" or "xdg-open"

      -- Open the link in the browser when the user selects one
      map("i", "<CR>", function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        local text = selection[1]
        local url = vim.tbl_filter(function(entry) return entry.text == text end, links)[1].url
        vim.fn.jobstart({ opener, url }, { detach = true })
      end)

      map("n", "<CR>", function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        local text = selection[1]
        local url = vim.tbl_filter(function(entry) return entry.text == text end, links)[1].url
        vim.fn.jobstart({ opener, url }, { detach = true })
      end)

      return true
    end,
  }):find()
end

return M
