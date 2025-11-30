-- --------------------------------
-- AutoSession: セッション管理
-- --------------------------------
return {
  "rmagatti/auto-session",
  config = function()
    require("auto-session").setup({
      -- セッションの保存先
      auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",

      -- 自動セッション管理を有効化
      auto_session_enabled = true,

      -- 自動保存を有効化
      auto_save_enabled = true,

      -- 自動復元を有効化（Neovim起動時）
      auto_restore_enabled = true,

      -- セッションを保存しないディレクトリ
      auto_session_suppress_dirs = {
        "~/",
        "~/Downloads",
        "~/Documents",
        "/",
      },

      -- ログレベル
      log_level = "error",

      -- セッション保存前に実行するコマンド
      pre_save_cmds = {
        "Neotree close",           -- neo-treeを閉じる
        "lua vim.notify('Saving session...', vim.log.levels.INFO)",
      },

      -- セッション復元後に実行するコマンド
      post_restore_cmds = {
        "Neotree filesystem show",  -- neo-treeを開く
        "lua vim.notify('Session restored!', vim.log.levels.INFO)",
      },

      -- セッション保存のタイミング
      -- VimLeavePre（Neovim終了時）に保存
      auto_session_use_git_branch = false,

      -- セッションレンズ（Telescope統合）
      session_lens = {
        -- バッファをロードするか
        buftypes_to_ignore = {},
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
      },
    })

    -- キーマップ
    vim.keymap.set("n", "<leader>ss", "<cmd>SessionSave<cr>", { desc = "Save session" })
    vim.keymap.set("n", "<leader>sr", "<cmd>SessionRestore<cr>", { desc = "Restore session" })
    vim.keymap.set("n", "<leader>sd", "<cmd>SessionDelete<cr>", { desc = "Delete session" })
    vim.keymap.set("n", "<leader>sf", "<cmd>Autosession search<cr>", { desc = "Find sessions" })
    vim.keymap.set("n", "<leader>sD", "<cmd>Autosession delete<cr>", { desc = "Delete session (picker)" })
  end,
}
