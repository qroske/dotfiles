-- --------------------------------
-- Which-key: キーマップヘルプの表示
-- --------------------------------
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- 非常に遅延してロードする
    init = function()
      vim.o.timeout = true -- キー入力のタイムアウトを有効化
      vim.o.timeoutlen = 300 -- 300ms待って次のキー入力がない場合、Which-keyを表示
    end,
    opts = {
      -- Which-keyの初期設定
      plugins = {
        marks = true, -- ' を使ったマークのヘルプ
        registers = true, -- " を使ったレジスタのヘルプ
        spelling = {
          enabled = true, -- スペルチェックのヘルプ表示を有効化
          suggestions = 20 -- スペルミスの候補を最大20個表示
        }
      },
      -- その他の設定はデフォルトを使用
    },
    config = function(_, opts)
      local plugin = require("which-key")
      plugin.setup(opts)
    end,
  },
}
