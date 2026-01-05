local wezterm = require("wezterm")
local action = wezterm.action

return {
  -- --------------------------------
  -- デフォルトキーテーブル
  -- --------------------------------
  keys = {
    -- Workspace切り替え
    {
      key = "w",
      mods = "LEADER",
      action = action.ShowLauncherArgs({ flags = "WORKSPACES", title = "Select Workspace" }),
    },
    -- Workspace名変更
    {
      key = "$",
      mods = "LEADER",
      action = action.PromptInputLine({
        description = "(wezterm) Set Workspace Title:",
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
          end
        end),
      }),
    },
    -- Workspace作成
    {
      key = "W",
      mods = "LEADER|SHIFT",
      action = action.PromptInputLine({
        description = "(wezterm) Create New Workspace:",
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window.perform_action(action.SwitchToWorkspace({ name = line }), pane)
          end
        end),
      }),
    },
    -- コマンドパレット表示
    { key = "p", mods = "SUPER", action = action.ActivateCommandPalette },
    -- Tab移動
    { key = "Tab", mods = "CTRL", action = action.ActivateTabRelative(1) },
    { key = "Tab", mods = "SHIFT|CTRL", action = action.ActivateTabRelative(-1) },
    -- Tab入れ替え
    { key = "{", mods = "LEADER", action = action({ MoveTabRelative = -1 }) },
    -- Tab新規作成
    { key = "t", mods = "SUPER", action = action({ SpawnTab = "CurrentPaneDomain" }) },
    -- Tabを閉じる
    { key = "w", mods = "SUPER", action = action({ CloseCurrentTab = { confirm = true } }) },
    { key = "}", mods = "LEADER", action = action({ MoveTabRelative = 1 }) },
    -- コピーモード
    { key = "[", mods = "LEADER", action = action.ActivateCopyMode },
    -- コピー
    { key = "c", mods = "SUPER", action = action.CopyTo("Clipboard") },
    -- ペースト
    { key = "v", mods = "SUPER", action = action.PasteFrom("Clipboard") },
    -- Pane作成
    { key = "d", mods = "LEADER", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "r", mods = "LEADER", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    -- Paneを閉じる
    { key = "x", mods = "LEADER", action = action({ CloseCurrentPane = { confirm = true } }) },
    -- Pane移動
    { key = "h", mods = "LEADER", action = action.ActivatePaneDirection("Left") },
    { key = "l", mods = "LEADER", action = action.ActivatePaneDirection("Right") },
    { key = "k", mods = "LEADER", action = action.ActivatePaneDirection("Up") },
    { key = "j", mods = "LEADER", action = action.ActivatePaneDirection("Down") },
    -- Pane選択
    { key = "[", mods = "CTRL|SHIFT", action = action.PaneSelect },
    -- 選択中のPaneのみ表示
    { key = "z", mods = "LEADER", action = action.TogglePaneZoomState },
    -- フォントサイズ切り替え
    { key = "+", mods = "CTRL", action = action.IncreaseFontSize },
    { key = "-", mods = "CTRL", action = action.DecreaseFontSize },
    -- フォントサイズのリセット
    { key = "0", mods = "CTRL", action = action.ResetFontSize },
    -- タブ切り替え
    { key = "1", mods = "SUPER", action = action.ActivateTab(0) },
    { key = "2", mods = "SUPER", action = action.ActivateTab(1) },
    { key = "3", mods = "SUPER", action = action.ActivateTab(2) },
    { key = "4", mods = "SUPER", action = action.ActivateTab(3) },
    { key = "5", mods = "SUPER", action = action.ActivateTab(4) },
    { key = "6", mods = "SUPER", action = action.ActivateTab(5) },
    { key = "7", mods = "SUPER", action = action.ActivateTab(6) },
    { key = "8", mods = "SUPER", action = action.ActivateTab(7) },
    { key = "9", mods = "SUPER", action = action.ActivateTab(8) },
    -- 設定再読み込み
    { key = "r", mods = "SHIFT|CTRL", action = action.ReloadConfiguration },
    -- resize_paneキーテーブル
    { key = "s", mods = "LEADER", action = action.ActivateKeyTable({ name = "resize_pane", on_shot = false }) },
    -- activate_paneキーテーブル
    { key = "a", mods = "LEADER", action = action.ActivateKeyTable({ name = "activate_pane", timeout_milliseconds = 1000 }) },
  },
  -- --------------------------------
  -- デフォルトキーテーブル
  -- --------------------------------
  key_tables = {
    -- Paneサイズ調整モード（Leader + s）
    resize_pane = {
      { key = "h", action = action.AdjustPaneSize({ "Left", 1 }) },
      { key = "l", action = action.AdjustPaneSize({ "Right", 1 }) },
      { key = "k", action = action.AdjustPaneSize({ "Up", 1 }) },
      { key = "j", action = action.AdjustPaneSize({ "Down", 1 }) },
      -- モードをキャンセルする
      { key = "Enter", action = "PopKeyTable" },
    },
    -- Copyモード（Leader + [）
    copy_mode = {
      -- 移動
      { key = "h", mods = "NONE", action = action.CopyMode("MoveLeft") },
      { key = "j", mods = "NONE", action = action.CopyMode("MoveDown") },
      { key = "k", mods = "NONE", action = action.CopyMode("MoveUp") },
      { key = "l", mods = "NONE", action = action.CopyMode("MoveRight") },
      -- 最初と最後に移動
      { key = "^", mods = "NONE", action = action.CopyMode("MoveToStartOfLineContent") },
      { key = "$", mods = "NONE", action = action.CopyMode("MoveToEndOfLineContent") },
      -- 左端に移動
      { key = "0", mods = "NONE", action = action.CopyMode("MoveToStartOfLine") },
      { key = "o", mods = "NONE", action = action.CopyMode("MoveToSelectionOtherEnd") },
      { key = "O", mods = "NONE", action = action.CopyMode("MoveToSelectionOtherEndHoriz") },
      -- 直前の文字検索を繰り返す
      { key = ";", mods = "NONE", action = action.CopyMode("JumpAgain") },
      -- 単語ごと移動
      { key = "w", mods = "NONE", action = action.CopyMode("MoveForwardWord") },
      { key = "b", mods = "NONE", action = action.CopyMode("MoveBackwardWord") },
      { key = "e", mods = "NONE", action = action.CopyMode("MoveForwardWordEnd") },
      -- ジャンプ機能
      { key = "t", mods = "NONE", action = action.CopyMode({ JumpForward = { prev_char = true } })},
      { key = "f", mods = "NONE", action = action.CopyMode({ JumpForward = { prev_char = false } })},
      { key = "T", mods = "NONE", action = action.CopyMode({ JumpBackward = { prev_char = true } })},
      { key = "F", mods = "NONE", action = action.CopyMode({ JumpBackward = { prev_char = false } })},
      -- 一番下へ
      { key = "G", mods = "NONE", action = action.CopyMode("MoveToScrollbackBottom") },
      -- 一番上へ
      { key = "g", mods = "NONE", action = action.CopyMode("MoveToScrollbackTop") },
      -- viewport
      { key = "H", mods = "NONE", action = action.CopyMode("MoveToViewportTop") },
      { key = "L", mods = "NONE", action = action.CopyMode("MoveToViewportBottom") },
      { key = "M", mods = "NONE", action = action.CopyMode("MoveToViewportMiddle") },
      -- スクロール
      { key = "b", mods = "CTRL", action = action.CopyMode("PageUp") },
      { key = "f", mods = "CTRL", action = action.CopyMode("PageDown") },
      { key = "d", mods = "CTRL", action = action.CopyMode({ MoveByPage = 0.5 }) },
      { key = "u", mods = "CTRL", action = action.CopyMode({ MoveByPage = -0.5 }) },
      -- 範囲選択モード
      { key = "v", mods = "NONE", action = action.CopyMode({ SetSelectionMode = "Cell" }) },
      { key = "v", mods = "CTRL", action = action.CopyMode({ SetSelectionMode = "Block" }) },
      { key = "V", mods = "NONE", action = action.CopyMode({ SetSelectionMode = "Line" }) },
      -- コピー
      { key = "y", mods = "NONE", action = action.CopyTo("Clipboard") },
      -- コピーモードを終了
      {
        key = "Enter",
        mods = "NONE",
        action = action.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } })
      },
      { key = "Escape", mods = "NONE", action = action.CopyMode("Close") },
      { key = "c", mods = "CTRL", action = action.CopyMode("Close") },
      { key = "q", mods = "NONE", action = action.CopyMode("Close") },
    },
  },
}
