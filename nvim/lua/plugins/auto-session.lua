return {
  -- disable persistence
  { "folke/persistence.nvim", enabled = false },
  -- enable auto-session
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

      require("auto-session").setup({
        log_level = "info",
        -- Root dir where sessions will be stored
        root_dir = vim.fn.stdpath("data") .. "/sessions/",
        -- Suppress session restore/create in certain directories
        suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        -- Do not save sessions when only dashboard open
        bypass_save_filetypes = { "snacks_dashboard", "neo-tree" },
        -- Enable pre_cwd_changed_cmds and post_cwd_changed_cmds
        cwd_change_handling = true,
        -- Command to be executed before current working directory is changed
        pre_cwd_changed_cmds = {
          function()
            -- Close Neo-tree
            vim.cmd("Neotree close")
            -- Forcefully delete the Neo-tree buffer
            vim.cmd("silent! bdelete! Neo-tree")
          end,
        },
        -- Command to be executed after current working directory has been changed
        post_cwd_changed_cmds = {
          function()
            -- Delay of 100ms to ensure Neo-tree is properly reloaded
            vim.defer_fn(function()
              -- Reopen Neo-tree after changing the working directory
              vim.cmd("Neotree show")
              -- Refresh Lualine to update displayed working directory
              require("lualine").refresh()
            end, 200)
          end,
        },
      })
    end,
  },
}
