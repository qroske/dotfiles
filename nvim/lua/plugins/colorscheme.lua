-- --------------------------------
-- ColorScheme設定
-- --------------------------------
return {
  -- TokyoNight カラースキーム
  {
    "folke/tokyonight.nvim",
    lazy = false, -- Neovim起動時にすぐにロードする
    priority = 1000, -- 他のプラグインより先にロードされるように優先度を高く設定
    -- オプション設定
    opts = {
      style = "night", -- テーマのスタイルを 'night' に設定
      transparent = true, -- 透過を有効化
      styles = {
        sidebars = "transparent", -- Neo-treeなどのサイドバーを透過
        floats = "transparent", -- 浮き出しウィンドウを透過
      }
    },
    -- プラグインロード後の設定
    config = function(_, opts)
      require("tokyonight").setup(opts)
      -- Neovimが起動したら、カラースキームを 'tokyonight' に設定
      vim.cmd("colorscheme tokyonight")
    end
  },
}
