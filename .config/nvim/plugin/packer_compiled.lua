-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = true
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/jimmy/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/jimmy/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/jimmy/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/jimmy/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/jimmy/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  Coqtail = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/Coqtail",
    url = "https://github.com/whonore/Coqtail"
  },
  DrawIt = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/DrawIt",
    url = "https://github.com/vim-scripts/DrawIt"
  },
  ["Ionide-vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/Ionide-vim",
    url = "https://github.com/ionide/Ionide-vim"
  },
  ["asyncrun.vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/asyncrun.vim",
    url = "https://github.com/skywind3000/asyncrun.vim"
  },
  ["auto-session"] = {
    config = { "\27LJ\2\nå\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\31auto_session_suppress_dirs\1\4\0\0\a~/\v~/Repo\15~/Projects\1\0\1\14log_level\tinfo\nsetup\17auto-session\frequire\0" },
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  ["completion-nvim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/completion-nvim",
    url = "https://github.com/nvim-lua/completion-nvim"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/emmet-vim",
    url = "https://github.com/mattn/emmet-vim"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["glyphs-vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/glyphs-vim",
    url = "https://github.com/jummy233/glyphs-vim"
  },
  ["goyo.vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/goyo.vim",
    url = "https://github.com/junegunn/goyo.vim"
  },
  gruvbox = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/gruvbox",
    url = "https://github.com/morhetz/gruvbox"
  },
  ["haskell-vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/haskell-vim",
    url = "https://github.com/neovimhaskell/haskell-vim"
  },
  ["lean.nvim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/lean.nvim",
    url = "https://github.com/Julian/lean.nvim"
  },
  nerdtree = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/nerdtree",
    url = "https://github.com/preservim/nerdtree"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/nvim-compe",
    url = "https://github.com/hrsh7th/nvim-compe"
  },
  ["nvim-lsp"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/nvim-lsp",
    url = "https://github.com/neovim/nvim-lsp"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-lsputils"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/nvim-lsputils",
    url = "https://github.com/RishabhRD/nvim-lsputils"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  popfix = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/popfix",
    url = "https://github.com/RishabhRD/popfix"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["purescript-vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/purescript-vim",
    url = "https://github.com/purescript-contrib/purescript-vim"
  },
  ["rainbow_parentheses.vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/rainbow_parentheses.vim",
    url = "https://github.com/kien/rainbow_parentheses.vim"
  },
  ["scratch.vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/scratch.vim",
    url = "https://github.com/mtth/scratch.vim"
  },
  slimv = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/slimv",
    url = "https://github.com/kovisoft/slimv"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["typescript-vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/typescript-vim",
    url = "https://github.com/leafgarland/typescript-vim"
  },
  ultisnips = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/ultisnips",
    url = "https://github.com/SirVer/ultisnips"
  },
  ["vim-apl"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-apl",
    url = "https://github.com/justin2004/vim-apl"
  },
  ["vim-better-sml"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-better-sml",
    url = "https://github.com/jez/vim-better-sml"
  },
  ["vim-carbon-now-sh"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-carbon-now-sh",
    url = "https://github.com/kristijanhusak/vim-carbon-now-sh"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-floaterm"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-floaterm",
    url = "https://github.com/voldikss/vim-floaterm"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-indent-guides"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-indent-guides",
    url = "https://github.com/nathanaelkane/vim-indent-guides"
  },
  ["vim-javascript"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-javascript",
    url = "https://github.com/pangloss/vim-javascript"
  },
  ["vim-jsx-typescript"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-jsx-typescript",
    url = "https://github.com/peitalin/vim-jsx-typescript"
  },
  ["vim-koka"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-koka",
    url = "https://github.com/Nymphium/vim-koka"
  },
  ["vim-llvm"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-llvm",
    url = "https://github.com/rhysd/vim-llvm"
  },
  ["vim-markdown"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-markdown",
    url = "https://github.com/plasticboy/vim-markdown"
  },
  ["vim-misc"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-misc",
    url = "https://github.com/xolox/vim-misc"
  },
  ["vim-monochrome-waifu"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-monochrome-waifu",
    url = "https://github.com/ailrk/vim-monochrome-waifu"
  },
  ["vim-nix"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-nix",
    url = "https://github.com/LnL7/vim-nix"
  },
  ["vim-notes"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-notes",
    url = "https://github.com/xolox/vim-notes"
  },
  ["vim-rest-console"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-rest-console",
    url = "https://github.com/diepm/vim-rest-console"
  },
  ["vim-slime"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-slime",
    url = "https://github.com/jpalardy/vim-slime"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-snippets",
    url = "https://github.com/honza/vim-snippets"
  },
  ["vim-srcery"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-srcery",
    url = "https://github.com/roosta/vim-srcery"
  },
  ["vim-system-copy"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-system-copy",
    url = "https://github.com/christoomey/vim-system-copy"
  },
  vimtex = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vimtex",
    url = "https://github.com/lervag/vimtex"
  },
  ["vista.vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vista.vim",
    url = "https://github.com/liuchengxu/vista.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: auto-session
time([[Config for auto-session]], true)
try_loadstring("\27LJ\2\nå\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\31auto_session_suppress_dirs\1\4\0\0\a~/\v~/Repo\15~/Projects\1\0\1\14log_level\tinfo\nsetup\17auto-session\frequire\0", "config", "auto-session")
time([[Config for auto-session]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
