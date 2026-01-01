-- ---------------------------------------
-- indent-blankline.nvim: インデントガイド
-- ---------------------------------------
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3b4261" }) -- 通常インデントの色を設定
    vim.api.nvim_set_hl(0, "IblScope", { fg = "#61AFEF", bold = true }) -- 現在のスコープの色を設定

    require("ibl").setup({
      -- ----------------------------------------------------------
      -- 通常のインデントガイドの設定
      -- ----------------------------------------------------------
      indent = {
        char = "│", -- スペースで作られたインデントを表示する文字
        tab_char = "→", -- タブで作られたインデントを表示する文字
        highlight = "IblIndent",
      },
      -- ----------------------------------------------------------
      -- 現在編集中のブロックの設定
      -- ----------------------------------------------------------
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
        char = "▎",
        highlight = "IblScope",
      },
    })
  end,
}
