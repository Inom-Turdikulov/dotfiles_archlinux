require("auto-session").setup {
  log_level = vim.log.levels.ERROR,
    auto_session_suppress_dirs = { "~/Projects/main/wiki", "~/", "~/Projects",
        "~/Downloads", "/", "/tmp" },
}
