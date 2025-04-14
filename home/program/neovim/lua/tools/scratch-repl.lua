-- Run any scrach buffer
local M = {}


local LANGS = {
  lua = {
    cmd = "lua",
    ext = "lua",
  },
  bash = {
    cmd = "bash",
    ext = "sh"
  },
  python3 = {
    cmd = "python3",
    ext = "py"
  },
}

local autocmdId = nil

local function openScratchRepl(lang)
  local tmpfile = vim.fn.tempname() .. "." .. LANGS[lang].ext
  local cmd = LANGS[lang].cmd
  if not cmd then
    vim.notify("Unsupported language: " .. lang, vim.log.levels.ERROR)
    return
  end

  -- Open vertical split with scratch buffer
  vim.cmd.vsplit()
  local buf = vim.api.nvim_create_buf(true, false)
  vim.keymap.set("n", "<leader>o", function() M.runScratch() end, { desc = "Run Scratch Buffer", silent = true })
  if not autocmdId then
    autocmdId = vim.api.nvim_create_autocmd("BufWipeout", {
      buffer = buf,
      callback = function()
        vim.keymap.del("n", "<leader>o", { buffer = buf })
        autocmdId = nil
      end,
      desc = "Clean up autocmd",
    })
  end

  vim.api.nvim_win_set_buf(0, buf)
  vim.bo[buf].filetype = lang
  vim.api.nvim_buf_set_name(buf, tmpfile)
  vim.cmd("edit " .. tmpfile)

  -- Save language + command to buffer variable
  vim.b.scratch_repl_cmd = cmd
  vim.b.scratch_repl_file = tmpfile
end


local function openOutputBuffer(buf, lines)
  if not lines then return end
  -- Strip trailing empty line from job output
  if lines[#lines] == "" then
    table.remove(lines)
  end

  for i, line in ipairs(lines) do
    lines[i] = line:gsub("\r", "")
  end

  -- Write to buffer.
  vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)
end


-- Run buffer and show output
function M.runScratch()
  local cmd = vim.b.scratch_repl_cmd
  local file = vim.b.scratch_repl_file
  if not (cmd and file) then
    vim.notify("Not a scratch REPL buffer", vim.log.levels.ERROR)
    return
  end

  vim.cmd.write()
  local outputTmpfile = vim.fn.tempname()
  local outBuf = vim.api.nvim_create_buf(true, false)
  vim.bo[outBuf].buftype = "nofile"
  vim.bo[outBuf].bufhidden = "wipe"
  vim.bo[outBuf].filetype = "output"
  vim.cmd("belowright split")
  vim.api.nvim_buf_set_name(outBuf, outputTmpfile)
  vim.api.nvim_win_set_buf(0, outBuf)
  vim.api.nvim_buf_set_lines(outBuf, 0, -1, false,
    {"=============", "OUTPUT", "=============", ""})

  vim.fn.jobstart({ cmd, file }, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      openOutputBuffer(outBuf, data)
    end,
    on_stderr = function(_) end,
    on_exit = function(_, code)
      if code ~= 0 then
        vim.notify("Process exited with code " .. code, vim.log.levels.WARN)
      end
    end,
  })
end

-- Telescope picker
function M.start()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = "Select REPL Language",
    finder = finders.new_table {
      results = vim.tbl_keys(LANGS),
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      map("i", "<CR>", function()
        actions.close(prompt_bufnr)
        local lang = action_state.get_selected_entry().value
        openScratchRepl(lang)
      end)
      return true
    end,
  }):find()
end


return M
