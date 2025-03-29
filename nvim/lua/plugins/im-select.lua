return {
  "keaising/im-select.nvim",
  opts = {
    -- IM will be set to `default_im_select` in `normal` mode
    default_im_select = "com.apple.keylayout.ABC",
    default_command = "macism",
    -- Restore the default input method state when the following events are triggered
    set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },
    -- Restore the previous used input method state when the following events are triggered
    set_previous_events = { "InsertEnter" },
    -- Show notification about how to install executable binary when binary missed
    keep_quiet_on_no_binary = false,
    -- Async run `default_command` to switch IM or not
    async_switch_im = true,
  },
}
