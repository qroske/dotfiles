-- --------------------------------
-- telescope.nvim: 曖昧検索ツール
-- --------------------------------
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",              -- Telescopeの基本機能を提供するライブラリ
    "nvim-telescope/telescope-ui-select.nvim", -- 選択画面をTelescopeのデザインで統一する
  },

  config = function()
    -- Telescopeの機能を使えるようにする
    local telescope = require("telescope")
    local actions = require("telescope.actions") -- キー操作の設定用

    telescope.setup({
      -- 全てのTelescope機能に共通する設定
      defaults = {
        -- キーボード操作の設定
        mappings = {
          -- iは「挿入モード」（文字を入力している状態）での操作
          i = {
            -- Ctrl+jで下の候補に移動
            ["<C-j>"] = actions.move_selection_next,
            -- Ctrl+kで上の候補に移動
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },

      -- 拡張機能ごとの個別設定
      extensions = {
        -- セッションレンズ（保存した作業状態を呼び出す機能）の設定
        session_lens = {
          -- 見た目の設定
          theme_conf = {
            border = true, -- ウィンドウに枠線を表示する
            layout_config = {
              width = 0.8,  -- 画面の横幅の80%のサイズで表示
              height = 0.6, -- 画面の縦幅の60%のサイズで表示
            },
          },
        },
      },
    })

    -- 追加の拡張機能を有効化する
    telescope.load_extension('projects')      -- プロジェクト（作業フォルダ）を素早く切り替える
    telescope.load_extension('session-lens')  -- 保存した作業状態を復元する
    telescope.load_extension('ui-select')     -- Neovimの選択画面をTelescopeのデザインに統一
  end,
}
