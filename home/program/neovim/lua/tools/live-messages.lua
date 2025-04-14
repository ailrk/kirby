local M = {}


local messagesBuf = nil
local running = false

local function updateMessagesBuffer()
  local messages = vim.api.nvim_exec2("messages", { output = true }).output
  local lines = vim.split(messages, "\n", { plain = true })

  if messagesBuf and vim.api.nvim_buf_is_valid(messagesBuf) then
    vim.api.nvim_buf_set_lines(messagesBuf, 0, -1, false, lines)
  else
    messagesBuf = vim.api.nvim_create_buf(false, true)
    vim.bo[messagesBuf].bufhidden = "wipe"
    vim.bo[messagesBuf].filetype = "messages"
    vim.cmd.vsplit() -- split to the right
    vim.api.nvim_win_set_buf(0, messagesBuf)
    vim.api.nvim_buf_set_lines(messagesBuf, 0, -1, false, lines)
  end

  -- schedule next update
  if running then
    print("next")
    vim.defer_fn(updateMessagesBuffer, 500)
  else
    vim.api.nvim_buf_delete(messagesBuf, { force = false })
  end
end

local function toggle()
  if running then
    running = false
    print("Closing live messages")
    return
  end
  running = true
  updateMessagesBuffer()
end

M.toggleLiveMessages = toggle

return M
