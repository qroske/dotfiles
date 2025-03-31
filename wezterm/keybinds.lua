local wezterm = require("wezterm")
local action = wezterm.action

return {
	keys = {
		-- cmd + w でペインを閉じる（デフォルトではタブが閉じる）
		{ key = "w", mods = "CMD", action = action.CloseCurrentPane({ confirm = true }) },
		-- cmd + shift + d で画面を分割
		{ key = "d", mods = "CMD", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		-- cmd + shift + d で下方向にペイン分割
		{ key = "d", mods = "CMD|SHIFT", action = action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
		-- Tab移動
		{ key = "1", mods = "CTRL", action = action.ActivateTabRelative(1) },
		{ key = "2", mods = "CTRL", action = action.ActivateTabRelative(-1) },
		-- Workspace選択
		{
			key = "w",
			mods = "CMD|SHIFT",
			action = action.ShowLauncherArgs({ flags = "WORKSPACES", title = "Select workspace" }),
		},
		-- Workspace名変更
		{
			key = "r",
			mods = "CMD|SHIFT",
			action = action.PromptInputLine({
				description = "Workspace Name:",
				action = wezterm.action_callback(function(_, _, line)
					if line then
						wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
					end
				end),
			}),
		},
	},
}
