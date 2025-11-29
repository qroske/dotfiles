-- --------------------------------
-- Neo-tree.nvim: ファイラー
-- --------------------------------
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim", -- ファイルシステムのスキャンなどのバックエンドユーティリティ用
    "MunifTanjim/nui.nvim", -- ツリーを含む全てのUIコンポーネント
    "nvim-tree/nvim-web-devicons", -- アイコン表示用（オプション）
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true, -- 最後のウィンドウならneo-treeを閉じる
      window = {
        width = 30,
      },
      filesystem = {
        follow_current_file = {
          enabled = true, -- 現在のファイルを追跡
        },
        use_libuv_file_watcher = true, -- ファイル変更を自動検知
      },
    })
  end,
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
  },
}
