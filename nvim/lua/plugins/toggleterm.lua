-- -----------------------------------
-- toggleterm.nvim: ターミナル切り替え
-- -----------------------------------
return {
  "akinsho/toggleterm.nvim",
  version = "*", -- 最新安定版を使用
  config = function()
    require("toggleterm").setup({
      -- -----------------------------------
      -- ターミナルの表示方向
      -- float: フローティングウィンドウ
      -- horizontal: 水平分割（下部）
      -- vertical: 垂直分割（右側）
      -- tab: 新しいタブ
      -- -----------------------------------
      direction = "float",
      -- -----------------------------------
      -- フローティングウィンドウの詳細設定
      -- -----------------------------------
      float_opts = {
        -- -----------------------------------
        -- ボーダーのスタイル
        -- single: 一重線
        -- double: 二重線
        -- shadow: 影付き
        -- curved: 丸みを帯びた角
        -- none: ボーダーなし
        -- -----------------------------------
        border = "curved",
        winblend = 3, -- ウィンドウの透明度（0 - 100）
        width = math.floor(vim.o.columns * 0.95), -- ウィンドウ幅（画面幅の95%）
        height = math.floor(vim.o.lines * 0.95), -- ウィンドウの高さ（画面高さの95%）
      },

      open_mapping = [[<C-\>]], -- ターミナルの開閉
      insert_mappings = true, -- ノーマルモードでもopen_mappingを有効にする
      terminal_mappings = true, -- ターミナル内でもopen_mappingを有効にする
      hide_numbers = true, -- ターミナルウィンドウで行番号を非表示
      shade_terminals = true, -- ターミナルの背景を暗くする
      shading_factor = 2, -- 背景の暗さの度合い
      start_in_insert = true, -- ターミナルを開いたとき自動的にインサートモードにする
      persist_mode = true, -- ターミナルを閉じても次回開いたときにサイズを保持
      close_on_exit = true, -- ターミナルのプロセスが終了したらウィンドウを自動で閉じる
      -- -----------------------------------
      -- ターミナルが開かれたときのコールバック
      -- -----------------------------------
      on_open = function(term)
        local opts = { buffer = term.bufnr }
        -- termianlを閉じる
        vim.keymap.set("t", "<leader>tt", [[<C-\><C-n><cmd>close<CR>]], opts)
        vim.keymap.set("n", "<leader>tt", "<cmd>close<CR>", opts)
      end,
    })

    -- -----------------------------------
    -- lazygit用の設定
    -- -----------------------------------
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit", -- 起動するコマンド
      direction = "float", -- フローティングウィンドウで表示
      hidden = true, -- toggletermのターミナル番号リストに表示しない。通常ターミナルと別管理
      -- -----------------------------------
      -- ターミナルが開かれたときのコールバック
      -- -----------------------------------
      on_open = function(term)
        -- 強制的にインサートモードにする
        vim.cmd("startinsert!")
        -- termianlを閉じる
        local opts = { buffer = term.bufnr }
        vim.keymap.set("t", "Esc", [[<C-\><C-n><cmd>close<CR>]], opts)
        vim.keymap.set("n", "<leader>tt", "<cmd>close<CR>", opts)
      end,
    })

    -- -----------------------------------
    -- キーマッピング追加
    -- -----------------------------------
    -- terminal open
    vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Terminal: toggle" })
    -- lazygit open
    vim.keymap.set("n", "<leader>tg", function() lazygit:toggle() end, { desc = "Terminal: lazygit" })
  end,
}
