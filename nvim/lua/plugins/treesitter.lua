-- --------------------------------
-- Treesitter設定
-- --------------------------------
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate", -- インストール後に自動でパーサーを更新
    config = function()
      -- 自動インストールする言語
      require("nvim-treesitter").install({
          "lua",
          "vim",
          "vimdoc",
          "javascript",
          "typescript",
          "python",
          "rust",
          "go",
          "html",
          "css",
          "json",
          "yaml",
          "toml",
          "markdown",
          "markdown_inline",
          "bash",
          "regex",
      })
    end
  },
}
