local pickers      = require("telescope.pickers")
local finders      = require("telescope.finders")
local conf         = require("telescope.config").values
local actions      = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

local config = {
  audit_root = vim.fn.expand("$HOME/audit")
}

function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})
end

local function get_git_root()
  local result = vim.fn.systemlist("git rev-parse --show-toplevel")
  if vim.v.shell_error ~= 0 then return nil end
  return result[1]
end

local function get_today()
  return os.date("%Y-%m-%d")
end

local function audit_log_path(dir)
  local date = get_today()
  local filename = string.format("%s/%s.log", dir, date)
  return filename
end

local function ensure_audit_dir(project)
  local dir = string.format("%s/%s", config.audit_root, project)
  if vim.fn.isdirectory(dir) == 0 then
    vim.loop.fs_mkdir(dir, tonumber("755", 8), function(err)  -- 493 = 0755 in decimal
      if err then
        print("Failed to create dir: " .. err)
      else
        print("Directory created: " .. dir)
      end
    end)
  end
  return dir
end

local function list_audit_logs(dir)
  local logs = {}
  local entries = vim.fn.readdir(dir)
  local sep = dir:sub(-1) == "/" and "" or "/"
  for _, p in ipairs(entries) do
    local full_path = dir .. sep .. p
    table.insert(logs, full_path)
  end
  return logs
end

function M.audit_open()
  local git_root = get_git_root()
  if not git_root then
    vim.notify("Not in a git repository", vim.log.levels.ERROR)
    return
  end

  if vim.fn.isdirectory(config.audit_root) == 0 then
    vim.notify("Audit repo " .. config.audit_root .. " doesn't exist", vim.log.levels.ERROR)
    return
  end

  local project =  vim.fn.fnamemodify(git_root, ":t")
  local dir = ensure_audit_dir(project)

  local logs = list_audit_logs(dir)
  local new_log = audit_log_path(dir)
  if not vim.loop.fs_stat(new_log) then
    local fd = vim.loop.fs_open(new_log, "w", tonumber("755", 8))
    table.insert(logs, new_log)
    if fd then
      vim.loop.fs_close(fd)
      print("File created (libuv): " .. new_log)
    else
      print("Failed to create file")
    end
  end

  pickers.new({}, {
    prompt_title = "Audit Logs - " .. project,
    finder = finders.new_table {
      results = logs,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
        }
      end,
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.cmd("edit " .. selection.value)
      end)
      return true
    end,
  }):find()
end

return M
