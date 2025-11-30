-- --------------------------------
-- project.nvim: プロジェクト管理
-- --------------------------------
return {
  "ahmedkhalf/project.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "rmagatti/auto-session", -- セッション管理との連携
  },
  event = "VeryLazy",
  config = function()
    require("project_nvim").setup({
      -- ========================================
      -- プロジェクト検出設定
      -- ========================================

      -- 検出方法（lsp: LSPのルート、pattern: パターンマッチ）
      detection_methods = { "lsp", "pattern" },

      -- プロジェクトルートと判断するファイル/ディレクトリ
      patterns = {
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        "Makefile",
        "package.json",      -- Node.js
        "go.mod",            -- Go
        "Cargo.toml",        -- Rust
        "pyproject.toml",    -- Python
        "requirements.txt",  -- Python
        "pom.xml",           -- Java/Maven
        "build.gradle",      -- Java/Gradle
        "composer.json",     -- PHP
        "Gemfile",           -- Ruby
        ".project",          -- Eclipse
        "CMakeLists.txt",    -- C/C++
      },

      -- ========================================
      -- 除外設定
      -- ========================================

      -- プロジェクトルートから除外するディレクトリ
      exclude_dirs = {
        "~/",
        "~/Downloads",
        "~/Documents",
      },

      -- 無視するLSP
      ignore_lsp = {},

      -- ========================================
      -- 動作設定
      -- ========================================

      -- プロジェクト変更時に自動でディレクトリを移動
      silent_chdir = true,

      -- ディレクトリ変更のスコープ
      -- 'global': グローバルに変更（:cd）
      -- 'tab': タブごとに変更（:tcd）
      -- 'win': ウィンドウごとに変更（:lcd）
      scope_chdir = 'global',

      -- データの保存先
      datapath = vim.fn.stdpath("data"),

      -- ========================================
      -- auto-sessionとの連携設定
      -- ========================================

      -- プロジェクト変更時にセッションを自動保存/復元
      -- これにより、プロジェクトを切り替えると前回の状態が復元される
    })

    -- Telescopeとの連携
    require('telescope').load_extension('projects')

    -- ========================================
    -- キーマップ
    -- ========================================

    vim.keymap.set('n', '<leader>fp', '<cmd>Telescope projects<cr>', { desc = 'Find projects' })

    -- ========================================
    -- 自動コマンド（重要）
    -- ========================================

    -- プロジェクト変更時にセッションを復元
    vim.api.nvim_create_autocmd("DirChanged", {
      callback = function()
        -- 新しいディレクトリでセッションを復元
        vim.defer_fn(function()
          local session_file = vim.fn.stdpath("data") .. "/sessions/" ..
                               vim.fn.getcwd():gsub("/", "%%") .. ".vim"
          if vim.fn.filereadable(session_file) == 1 then
            vim.cmd("SessionRestore")
          end
        end, 100)
      end,
    })
  end,
}
