vim.g.copilot_proxy = "localhost:11435"

-- Standard Keybinds
vim.g.copilot_no_tab_map = true
vim.keymap.set("i", "<Tab>", function()
  if vim.fn['copilot#Accept']('') ~= '' then
    return vim.fn['copilot#Accept']('')
  else
    return "<Tab>"
  end
end, { expr = true, silent = true })
