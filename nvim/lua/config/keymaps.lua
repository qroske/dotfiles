-- 基本的なキーバインドの設定
local map = vim.api.nvim_set_keymap

-- ---------------
-- window
-- ---------------
-- move
map("n", "<Leader>j", "<C-w>j", { noremap = true, silent = true }) -- ノーマルモードでウィンドウを下に移動
map("n", "<Leader>k", "<C-w>k", { noremap = true, silent = true }) -- ノーマルモードでウィンドウを上に移動
map("n", "<Leader>l", "<C-w>l", { noremap = true, silent = true }) -- ノーマルモードでウィンドウを右に移動
map("n", "<Leader>h", "<C-w>h", { noremap = true, silent = true }) -- ノーマルモードでウィンドウを左に移動

-- split
map("n", "<Leader>s", ":<C-u>sp\n", { noremap = true }) -- ノーマルモードでウィンドウの水平分割
map("n", "<Leader>v", ":<C-u>vs\n", { noremap = true }) -- ノーマルモードでウィンドウの垂直分割
-- close
map("n", "<Leader>w", ":<C-u>w\n", { noremap = true }) -- ノーマルモードで現在のウィンドウを保存する
map("n", "<Leader>wq", ":<C-u>wq\n", { noremap = true }) -- ノーマルモードで現在のウィンドウを保存して閉じる
map("n", "<Leader>q", ":<C-u>q\n", { noremap = true }) -- ノーマルモードで現在のウィンドウを閉じる
map("n", "<Leader>q!", ":<C-u>q!\n", { noremap = true }) -- ノーマルモードで現在のウィンドウを強制的に閉じる

-- ---------------
-- cursor
-- ---------------
-- move
map("i", "<C-j>", "<Down>", {}) -- インサートモードでカーソルを下に移動
map("i", "<C-k>", "<Up>", {}) -- インサートモードでカーソルを上に移動
map("i", "<C-l>", "<Right>", {}) -- インサートモードでカーソルを右に移動
map("i", "<C-h>", "<Left>", {}) -- インサートモードでカーソルを左に移動

-- ---------------
-- terminal
-- ---------------
-- open
map("n", "<Leader>tt", ":terminal\n", { noremap = true }) -- ノーマルモードでターミナルウィンドウを開く

-- ---------------
-- diagnostics
-- ---------------
-- show
map("n", "<Leader>d", ":lua vim.diagnostic.open_float()<CR>", { noremap = true }) -- ノーマルモードでエラーや警告を表示する

-- ---------------
-- project
-- ---------------
map("n", "<Leader>p", ":Telescope project", { noremap = true, silent = true })

-- ---------------
-- rebind
-- ---------------
-- comment
map("n", "<C-_>", "gcc", { noremap = false }) -- ノーマルモードでコメントアウト/コメント解除
map("v", "<C-_>", "gc", { noremap = false }) -- ヴィジュアルモードでコメントアウト/コメント解除
