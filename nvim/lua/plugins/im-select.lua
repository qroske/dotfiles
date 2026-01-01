-- --------------------------------
-- im-select.nvim: IME切り替え
-- --------------------------------
return {
  "keaising/im-select.nvim",
  config = function()
    require("im_select").setup({
      -- Normalモードで使用するIM（英語モード）
      default_im_select = "com.apple.keylayout.ABC",
      -- macOS用のコマンド
      default_command = "macism",
      -- Insertモードとコマンドラインモードを抜けた時、英語に切り替え
      set_default_events = { "InsertLeave", "CmdlineLeave" },
      -- Insertモードに入った時に直前のIMに戻す
      set_previous_events = { "InsertEnter" },
    })
  end,
}
