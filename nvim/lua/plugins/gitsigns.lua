-- --------------------------------
-- gitsigns.nvim: Git関連便利機能
-- --------------------------------
return {
  "lewis6991/gitsigns.nvim",
  -- バッファを読み込むときにプラグインを読み込む（起動時間を短縮）
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      -- 行番号の左側に表示される変更マークの設定
      signs = {
        add          = { text = '┃' }, -- 新規追加行
        change       = { text = '┃' }, -- 変更行
        delete       = { text = '_' }, -- 削除行
        topdelete    = { text = '‾' }, -- ファイル先頭の削除
        changedelete = { text = '~' }, -- 変更後削除された行
        untracked    = { text = '┆' }, -- Gitで追跡されていないファイル
      },
      -- ステージングされた変更も表示する
      signs_staged_enable = true,

      -- 現在行のblame情報を自動表示するかどうか
      -- false: 手動で表示（<leader>gb）
      -- true: カーソル移動時に自動表示
      current_line_blame = true,

      -- blame自動表示の詳細設定
      current_line_blame_opts = {
        virt_text = true, -- 仮想テキストとして表示
        virt_text_pos = 'eol', -- 行末（end of line）に表示
        delay = 500, -- カーソル移動後、表示までの遅延（ミリ秒）
      },

      -- blame情報の表示フォーマット
      -- <author>: コミット作成者
      -- <author_time:%Y-%m-%d>: コミット日時（年-月-日形式）
      -- <summary>: コミットメッセージの要約
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',

      -- バッファにアタッチされたときに実行される関数
      -- ここでキーマッピングを設定
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        -- キーマッピング用のヘルパー関数
        -- mode: モード（'n'=ノーマルモード、'v'=ビジュアルモードなど）
        -- l: 押すキー（left side）
        -- r: 実行される関数/コマンド（right side）
        -- opts: オプション（説明など）
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr -- 現在のバッファにのみ適用
          vim.keymap.set(mode, l, r, opts)
        end

        -- ==========================================
        -- Git blame表示関連
        -- ==========================================

        -- <leader>gb: 現在行のblame情報を簡易表示
        -- 例: "John Doe, 2 hours ago - Fix typo"
        map('n', '<leader>gb', gs.blame_line, { desc = 'Git blame line' })

        -- <leader>gB: 現在行のblame情報を詳細表示
        -- フルのコミットメッセージ、ハッシュなども表示
        map('n', '<leader>gB', function() 
          gs.blame_line({full=true}) 
        end, { desc = 'Git blame line (full)' })

        -- ==========================================
        -- 変更箇所（hunk）間の移動
        -- ==========================================

        -- ]c: 次の変更箇所へジャンプ
        -- diffモード（:diffthis）との互換性を保つ
        map('n', ']c', function()
          -- diff モードの場合は通常の ]c の動作
          if vim.wo.diff then return ']c' end
          -- gitsigns の次のhunkへ移動
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc = 'Next change'})

        -- [c: 前の変更箇所へジャンプ
        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc = 'Previous change'})

        -- ==========================================
        -- 変更内容の確認・操作
        -- ==========================================

        -- <leader>gp: 現在の変更箇所の差分をプレビュー表示
        -- フローティングウィンドウで before/after を表示
        map('n', '<leader>gp', gs.preview_hunk, { desc = 'Preview change' })

        -- <leader>gr: 現在の変更箇所を元に戻す（リセット）
        -- 保存していない変更が失われるので注意
        map('n', '<leader>gr', gs.reset_hunk, { desc = 'Reset hunk' })

        -- ==========================================
        -- Git ステージング操作
        -- ==========================================

        -- <leader>gs: 現在の変更箇所をステージング
        -- git add -p 相当の操作
        map('n', '<leader>gs', gs.stage_hunk, { desc = 'Stage hunk' })

        -- <leader>gu: ステージングを取り消し
        -- git reset HEAD 相当の操作
        map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
      end,
    })
  end,
}
