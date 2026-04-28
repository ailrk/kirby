vim.g.copilot_proxy = "localhost:11435"
vim.g.copilot_no_tab_map = true
vim.g.copilot_enabled = true

vim.keymap.set(
  "i",
  "<C-x>",
  function()
    return vim.fn['copilot#Accept']("<CR>")
  end,
  { expr = true, replace_keycodes = false })
