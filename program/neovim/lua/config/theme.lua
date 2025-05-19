local mode_file = vim.fn.expand("~/.config/kirby/color-mode")

if vim.fn.filereadable(mode_file) == 1 then
  local lines = vim.fn.readfile(mode_file)
  local mode = table.concat(lines, "\n"):gsub("^%s*(.-)%s*$", "%1") -- trim whitespace

  if mode == "dark" then
    vim.opt.background = "dark"
  elseif mode == "light" then
    vim.opt.background = "light"
  else
    vim.opt.background = "dark" -- fallback
  end
else
  vim.opt.background = "dark" -- fallback
end


vim.cmd.colorscheme("vim-monochrome-waifu")
