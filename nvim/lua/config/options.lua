-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- --------------------
-- Global
-- --------------------
local global = vim.g

global.mapleader = " " -- Spaceをグローバルリーダーキーに設定
global.maplocalleader = "\\" -- \をローカルリーダーキーに設定
global.root_spec = { "lsp", { ".git" }, "cwd" } -- ルートディレクトリの検出方法を設定
global.root_lsp_ignore = { "copilot" } -- ルートディレクトリ検出時にcopilotを無視
global.ai_cmp = false -- AIを使った補完を無効化
global.autoformat = true -- 自動フォーマットを有効化
global.deprecation_warnings = true -- 非推奨の警告メッセージを表示

-- --------------------
-- Options
-- --------------------
local options = vim.opt

options.encoding = "utf-8" -- 文字エンコーディングをUTF-8
options.list = true -- 不可視文字を表示
options.number = true -- 行番号を表示
options.relativenumber = false -- 絶対行番号で表示
options.autowrite = false -- ファイルの自動保存を無効化
options.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- SSH環境出ない場合にシステムのクリップボードと連携
options.completeopt = "menu,menuone,noselect" -- 補完メニューを表示。1つしかない場合でも表示。デフォルトは選択しない
options.wildmenu = true -- コマンド補完を強化
options.confirm = true -- 保存せずに終了しようすると確認を表示
options.ruler = true -- カーソル位置を表示
options.cursorline = true -- カーソル行をハイライト
options.showmatch = true -- 括弧の対応をハイライト
options.expandtab = true -- タブをスペースに変換
options.tabstop = 2 -- タブ文字の幅を2スペースに設定
options.ignorecase = false -- 検索時に大文字小文字を区別する
options.smartcase = true -- 検索時の大文字小文字の区別を自動判定
options.shiftwidth = 2 -- インデントの幅を2スペースに設定
options.autoindent = true -- 前の行のインデントを維持
options.smartindent = true -- 構造を自動認識してインデントを設定
options.wrap = false -- 行を折り返さない
options.termguicolors = true -- 24-bitのフルカラーを有効化
options.updatetime = 250 -- 変更検知を高速化
options.mouse = "a" -- mouse操作を有効化
