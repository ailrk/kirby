vim.opt.tabline = "%!v:lua.my_tabline()"

-- Define filetypes you want to ignore here
local ignored_filetypes = {
  nerdtree = true,
  Outline = true,
}

vim.opt.tabline = "%!v:lua.my_tabline()"

function _G.my_tabline()
  local s = ""
  for i = 1, vim.fn.tabpagenr("$") do
    local bufs = vim.fn.tabpagebuflist(i)
    local buf = bufs[vim.fn.tabpagewinnr(i)]

    local function skip(b)
      local ft = vim.bo[b].filetype:lower()
      return ignored_filetypes[ft] or ft:match("outline")
    end

    if skip(buf) then
      for _, b in ipairs(bufs) do
        if not skip(b) then buf = b; break end
      end
    end

    local name = vim.fn.fnamemodify(vim.fn.bufname(buf), ":t")
    name = name == "" and "[No Name]" or name
    local hl = i == vim.fn.tabpagenr() and "%#TabLineSel#" or "%#TabLine#"
    s = string.format("%s%%%dT%s %d: %s ", s, i, hl, i, name)
  end
  return s .. "%#TabLineFill#%T"
end
