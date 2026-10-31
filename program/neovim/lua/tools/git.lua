-- gitpick.lua: pick a git diff / blame / log view from Telescope and open it
-- in a new tab, rendered through delta.
--
-- Install: save as ~/.config/nvim/lua/gitpick.lua, then:
--
--   require("gitpick").setup()
--
-- Usage:
--   :GitPick          all actions
--   :GitPick diff     only diff actions
--   :GitPick blame    only blame actions
--   :GitPick log      only log actions
--
-- In the result tab: `q` closes it, scroll with the normal Neovim motions.
-- Needs: telescope.nvim, git, and (optionally) delta in $PATH.

local M = {}

local config = {
  delta = true,                          -- pipe output through delta when it is installed
  delta_args = { "--paging=never" },     -- extra delta flags (e.g. "--side-by-side")
  scrollback = 100000,                   -- terminal scrollback lines (nvim max is 100000)
  theme = "dropdown",                    -- "dropdown" or nil for telescope's default layout
  blame_context = 30,                    -- lines above/below cursor for "blame around cursor"
}

local function notify(msg, level)
  vim.notify("[gitpick] " .. msg, level or vim.log.levels.INFO)
end

---------------------------------------------------------------------------
-- context: which file / repo are we looking at
---------------------------------------------------------------------------

local function git_root(dir)
  local out = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--show-toplevel" })
  if vim.v.shell_error ~= 0 then
    return nil
  end
  return out[1]
end

local function get_context()
  local buf = vim.api.nvim_get_current_buf()
  local name = vim.api.nvim_buf_get_name(buf)
  local file = (name ~= "" and vim.bo[buf].buftype == "") and name or nil

  local dir = file and vim.fn.fnamemodify(file, ":h") or vim.fn.getcwd()
  if vim.fn.isdirectory(dir) == 0 then
    dir = vim.fn.getcwd()
  end

  local root = git_root(dir)
  if not root then
    notify("not inside a git repository", vim.log.levels.WARN)
    return nil
  end

  return {
    file = file,
    root = root,
    line = vim.api.nvim_win_get_cursor(0)[1],
    nlines = vim.api.nvim_buf_line_count(buf),
  }
end

---------------------------------------------------------------------------
-- run a git command in a new tab terminal, through delta
---------------------------------------------------------------------------

local function shell_join(args)
  return table.concat(vim.tbl_map(vim.fn.shellescape, args), " ")
end

---@param ctx table
---@param args string[] git arguments, e.g. { "diff", "--staged" }
---@param opts? { blame?: boolean, title?: string }
function M.run(ctx, args, opts)
  opts = opts or {}

  local git = { "git", "--no-pager" }
  if not opts.blame then
    -- delta wants colored diffs; blame must stay in git's default format
    vim.list_extend(git, { "-c", "color.ui=always" })
  end
  vim.list_extend(git, args)

  local cmd = shell_join(git)
  if config.delta and vim.fn.executable("delta") == 1 then
    local delta = { "delta" }
    vim.list_extend(delta, config.delta_args)
    cmd = cmd .. " | " .. shell_join(delta)
  end

  vim.cmd("tabnew")
  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  vim.bo[buf].scrollback = config.scrollback

  local job = {
    cwd = ctx.root,
    on_exit = function()
      -- output lands asynchronously; jump back to the top once it settled
      vim.defer_fn(function()
        if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == buf then
          pcall(vim.api.nvim_win_set_cursor, win, { 1, 0 })
        end
      end, 80)
    end,
  }
  local sh = { "sh", "-c", cmd }

  if vim.fn.has("nvim-0.11") == 1 then
    job.term = true
    vim.fn.jobstart(sh, job)
  else
    vim.fn.termopen(sh, job)
  end

  vim.bo[buf].bufhidden = "wipe"
  vim.keymap.set("n", "q", "<cmd>tabclose<cr>", { buffer = buf, nowait = true, silent = true })
  pcall(vim.api.nvim_buf_set_name, buf, ("git://%s [%d]"):format(opts.title or args[1], buf))
end

---------------------------------------------------------------------------
-- sub pickers (reuse telescope's builtin git pickers)
---------------------------------------------------------------------------

local function pick(builtin, ctx, cb, extra)
  local ok, builtins = pcall(require, "telescope.builtin")
  if not ok then
    return notify("telescope.nvim is required", vim.log.levels.ERROR)
  end
  local actions = require("telescope.actions")
  local state = require("telescope.actions.state")

  local opts = vim.tbl_extend("force", {
    cwd = ctx.root,
    attach_mappings = function(bufnr)
      actions.select_default:replace(function()
        local entry = state.get_selected_entry()
        actions.close(bufnr)
        if entry then
          vim.schedule(function()
            cb(entry.value)
          end)
        end
      end)
      return true
    end,
  }, extra or {})

  builtins[builtin](opts)
end

---------------------------------------------------------------------------
-- menu entries
---------------------------------------------------------------------------

local function items(ctx)
  local f = ctx.file

  local function go(args, opts)
    return function()
      M.run(ctx, args, opts)
    end
  end

  local function with_branch(fn)
    return function()
      pick("git_branches", ctx, fn)
    end
  end

  local function with_commit(fn)
    return function()
      pick("git_commits", ctx, fn)
    end
  end

  local function with_file_commit(fn)
    return function()
      pick("git_bcommits", ctx, fn, { current_file = f })
    end
  end

  local around_s = math.max(1, ctx.line - config.blame_context)
  local around_e = math.min(ctx.nlines, ctx.line + config.blame_context)

  return {
    -- repo-wide diffs
    { group = "diff", label = "Unstaged changes", run = go({ "diff" }) },
    { group = "diff", label = "Staged changes", run = go({ "diff", "--staged" }) },
    { group = "diff", label = "All changes vs HEAD", run = go({ "diff", "HEAD" }) },
    { group = "diff", label = "Stat overview vs HEAD", run = go({ "diff", "--stat", "HEAD" }) },
    {
      group = "diff",
      label = "Branch... (what a PR would contain)",
      run = with_branch(function(b)
        M.run(ctx, { "diff", b .. "...HEAD" }, { title = "diff " .. b })
      end),
    },
    {
      group = "diff",
      label = "Commit...",
      run = with_commit(function(sha)
        M.run(ctx, { "show", sha }, { title = "show " .. sha:sub(1, 8) })
      end),
    },

    -- current file diffs
    { group = "diff", file = true, label = "Current file: unstaged", run = go({ "diff", "--", f }) },
    { group = "diff", file = true, label = "Current file: staged", run = go({ "diff", "--staged", "--", f }) },
    { group = "diff", file = true, label = "Current file: vs HEAD", run = go({ "diff", "HEAD", "--", f }) },
    {
      group = "diff",
      file = true,
      label = "Current file: vs branch...",
      run = with_branch(function(b)
        M.run(ctx, { "diff", b, "--", f }, { title = "diff " .. b })
      end),
    },
    {
      group = "diff",
      file = true,
      label = "Current file: at commit...",
      run = with_file_commit(function(sha)
        M.run(ctx, { "show", sha, "--", f }, { title = "show " .. sha:sub(1, 8) })
      end),
    },

    -- blame
    { group = "blame", file = true, label = "Current file", run = go({ "blame", "--", f }, { blame = true }) },
    {
      group = "blame",
      file = true,
      label = "Current file (ignore whitespace / moved lines)",
      run = go({ "blame", "-w", "-M", "-C", "--", f }, { blame = true, title = "blame -wMC" }),
    },
    {
      group = "blame",
      file = true,
      label = ("Around cursor (%d-%d)"):format(around_s, around_e),
      run = go(
        { "blame", "-L", ("%d,%d"):format(around_s, around_e), "--", f },
        { blame = true, title = "blame -L" }
      ),
    },
    {
      group = "blame",
      file = true,
      label = "Current file as of commit...",
      run = with_commit(function(sha)
        M.run(ctx, { "blame", sha, "--", f }, { blame = true, title = "blame " .. sha:sub(1, 8) })
      end),
    },

    -- log
    { group = "log", file = true, label = "Current file history (patches)", run = go({ "log", "-p", "--follow", "--", f }) },
    { group = "log", label = "Repo log (last 50, patches)", run = go({ "log", "-p", "-n", "50" }) },
  }
end

---------------------------------------------------------------------------
-- main picker
---------------------------------------------------------------------------

---@param group? "diff"|"blame"|"log"
function M.pick(group)
  local ok = pcall(require, "telescope")
  if not ok then
    return notify("telescope.nvim is required", vim.log.levels.ERROR)
  end

  local ctx = get_context()
  if not ctx then
    return
  end

  local list = vim.tbl_filter(function(it)
    if it.file and not ctx.file then
      return false
    end
    return group == nil or it.group == group
  end, items(ctx))

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local state = require("telescope.actions.state")
  local entry_display = require("telescope.pickers.entry_display")

  local displayer = entry_display.create({
    separator = " ",
    items = { { width = 5 }, { remaining = true } },
  })

  local theme = {}
  if config.theme == "dropdown" then
    theme = require("telescope.themes").get_dropdown({})
  end

  pickers
    .new(theme, {
      prompt_title = "Git: " .. vim.fn.fnamemodify(ctx.root, ":t"),
      finder = finders.new_table({
        results = list,
        entry_maker = function(it)
          return {
            value = it,
            ordinal = it.group .. " " .. it.label,
            display = function(e)
              return displayer({
                { e.value.group, "TelescopeResultsIdentifier" },
                e.value.label,
              })
            end,
          }
        end,
      }),
      sorter = conf.generic_sorter(theme),
      attach_mappings = function(bufnr)
        actions.select_default:replace(function()
          local entry = state.get_selected_entry()
          actions.close(bufnr)
          if entry then
            vim.schedule(entry.value.run)
          end
        end)
        return true
      end,
    })
    :find()
end

---------------------------------------------------------------------------
-- setup
---------------------------------------------------------------------------

function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})

  vim.api.nvim_create_user_command("GitPick", function(o)
    M.pick(o.args ~= "" and o.args or nil)
  end, {
    nargs = "?",
    complete = function()
      return { "diff", "blame", "log" }
    end,
    desc = "Pick a git diff / blame / log view (Telescope + delta)",
  })
end

return M
