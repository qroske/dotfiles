-- Pull in the wezterm API
local wezterm = require("wezterm")
-- This table will hold the configuration.
local config = wezterm.config_builder()
-- 設定ファイルを監視して変更が検知されると自動読み込み
config.automatically_reload_config = true

---------------------------------------
-- configs
---------------------------------------
-- カラースキームの設定
config.color_scheme = "Tokyo Night"
-- フォント設定
config.font_size = 16
-- IMEで日本語入力をできるようにする
config.use_ime = true
-- 背景透過
config.window_background_opacity = 0.85
-- 背景にぼかしを追加
-- config.macos_window_background_blur = 20
-- タイトルバーの削除
config.window_decorations = "RESIZE"
-- タブの追加ボタンを非表示
config.show_new_tab_button_in_tab_bar = false
-- タブ同士の境界線を非表示
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  },
}
config.enable_tab_bar = true
config.exit_behavior = "CloseOnCleanExit"
config.clean_exit_codes = {}
---------------------------------------
-- keybinds
---------------------------------------
config.disable_default_key_bindings = false
config.keys = require("keybinds").keys

---------------------------------------
-- customize
---------------------------------------
-- Workspace名を左上に表示
wezterm.on("update-right-status", function(window, _)
  local workspace = window:active_workspace()
  window:set_left_status(wezterm.format({ { Text = workspace } }))
end)

return config
