-- Neovim組み込みの設定
-- https://neovim.io/doc/user/quickref.html#option-list
local option = vim.opt
local global = vim.g
local api = vim.api
local diagnostic = vim.diagnostic

option.encoding = "utf-8" -- 文字エンコーディングをUTF-8
option.number = true -- 行番号を表示
option.clipboard = "unnamedplus" -- システムのクリップボードと連携
option.list = true -- 不可視文字を表示
option.expandtab = true -- タブをスペースに変換
option.tabstop = 2 -- タブ文字の幅を2スペースに設定
option.shiftwidth = 2 -- インデントの幅を2スペースに設定
option.autoindent = true -- 前の行のインデントを維持
option.smartindent = true -- 構造を自動認識してインデントを設定
option.wrap = false -- 行を折り返さない
option.termguicolors = true -- 24-bitのフルカラーを有効化
option.wildmenu = true -- コマンド補完を強化
option.ruler = true -- カーソル位置を表示
option.smartcase = true -- 検索時の大文字小文字の区別を自動判定
option.showmatch = true -- 括弧の対応をハイライト
option.updatetime = 250 -- 変更検知を高速化

-- mapleader
global.mapleader = " " -- Spaceをグローバルリーダーキーに設定
global.maplocalleader = "\\" -- \をローカルリーダーキーに設定

-- autocmd
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = api.nvim_create_augroup("float_diagnostic", { clear = true }),
  callback = function ()
    diagnostic.open_float(nil, { focus = false })
  end
})
