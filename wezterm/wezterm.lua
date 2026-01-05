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
config.font_size = 15
-- IMEで日本語入力をできるようにする
config.use_ime = true
-- 背景透過
config.window_background_opacity = 0.85
-- 背景にぼかしを追加
config.macos_window_background_blur = 20
-- タイトルバーの削除
config.window_decorations = "RESIZE"
-- タブが一つしかない時に非表示
config.hide_tab_bar_if_only_one_tab = false
-- タブバーを透明にする
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}
-- タブバーを背景と同じ色（黒）にする
config.window_background_gradient = {
  colors = { "#000000" },
}
-- タブの追加ボタンを非表示
config.show_new_tab_button_in_tab_bar = false
-- タブの閉じるボタンを非表示(nightlyでのみ有効)
-- config.show_close_tab_button_in_tabs = false
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
-- デフォルトのキーバインディングを無効にする
config.disable_default_key_bindings = false
-- keybuinds.luaを読み込めるようにする
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
-- Leader Key
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }

---------------------------------------
-- customize
---------------------------------------
-- アクティブタブに色をつける
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
local WORKSPACE_ICON = wezterm.nerdfonts.oct_terminal
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#5c6d74"
  local foreground = "#FFFFFF"
  local edge_background = "none"

  if tab.is_active then
    background = "#4169e1"
    foreground = "#FFFFFF"
  end

  local edge_foreground = background
  local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)

wezterm.on("update-right-status", function(window, pane)
  -- Workspace名を左上に表示
  local workspace = window:active_workspace()
  local background = "none"
  local foreground = "#FFFFFF"

  window:set_left_status(wezterm.format({
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = " " .. WORKSPACE_ICON .. " " },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = workspace },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
   { Text = "" }
  }))

  -- キーテーブル名を右上に表示
  local key_table_name = window:active_key_table()
  if key_table_name then
    key_table_name = "   Table: " .. key_table_name .. "   "
  else
    key_table_name = "   Table: None   "
  end
  window:set_right_status(key_table_name or "")
end)

return config
