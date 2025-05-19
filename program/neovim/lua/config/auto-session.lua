require("auto-session").setup {
  suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
  cwd_change_handling = true,
  pre_cwd_changed_cmds = {
      "tabdo NERDTreeClose" -- Close NERDTree before saving session
  }
}
