-- --------------------------------
-- Vim Better Whitespace Plugin: Trailling Spaceを削除する
-- --------------------------------
return {
  "ntpeters/vim-better-whitespace",
  event = { "BufReadPre", "BufNewFile" }, -- 必要なときだけ読み込み
  config = function()
    -- 行末スペースを赤色で強調表示
    vim.g.better_whitespace_enabled = 1

    -- 保存時に自動削除
    vim.g.strip_whitespace_on_save = 1

    -- 確認なしで自動削除（1にすると確認あり）
    vim.g.strip_whitespace_confirm = 0

    -- Markdownなど、空白が意味を持つファイルは除外
    vim.g.better_whitespace_filetypes_blacklist = {
      'markdown',
      'diff',
      'git',
      'gitcommit',
      'unite',
      'qf',
      'help',
    }
  end,
}
