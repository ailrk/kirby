-- Toggle a live buffer that shows outputs from :messages
local M = {}


local messagesBuf = nil
local autocmdId = nil
local running = false

local function clear()
  messagesBuf = nil
  running = false
  if autocmdId then
    vim.api.nvim_del_autocmd(autocmdId)
    autocmdId = nil
  end
end


local function updateMessagesBuffer()
  local messages = vim.api.nvim_exec2("messages", { output = true }).output
  local lines = vim.split(messages, "\n", { plain = true })

  if messagesBuf and vim.api.nvim_buf_is_valid(messagesBuf) then
    vim.api.nvim_buf_set_lines(messagesBuf, 0, -1, false, lines)
  else
    messagesBuf = vim.api.nvim_create_buf(false, true)
    if not autocmdId then
      autocmdId = vim.api.nvim_create_autocmd("BufWinLeave", {
        buffer = messagesBuf,
        callback = function() clear() end,
        desc = "Stop LiveMessages updates when buffer is wiped",
      })
    end

    vim.bo[messagesBuf].bufhidden = "wipe"
    vim.bo[messagesBuf].filetype = "messages"
    vim.cmd.vsplit() -- split to the right
    vim.api.nvim_win_set_buf(0, messagesBuf)
    vim.api.nvim_buf_set_lines(messagesBuf, 0, -1, false, lines)
  end

  -- schedule next update
  if running then
    vim.defer_fn(updateMessagesBuffer, 500)
  else
    vim.api.nvim_buf_delete(messagesBuf, { force = false })
  end
end

local function toggle()
  if running then
    clear()
    print("LiveMessages buffer closed")
    return
  end
  running = true
  updateMessagesBuffer()
end


M.toggleLiveMessages = toggle

return M
