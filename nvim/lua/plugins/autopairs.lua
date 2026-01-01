-- --------------------------------
-- Autopair設定
-- --------------------------------
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter", -- Insertモードに入った時に読み込む
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local autopairs = require("nvim-autopairs")

    -- --------------------------------------
    -- 基本設定
    -- --------------------------------------
    autopairs.setup({
      -- --------------------------------------
      -- Treesitterとの連携
      -- コメントや文字列内では括弧補完を無効化
      -- --------------------------------------
      check_ts = true,
      ts_config = {
        lua = { "string" }, -- Luaの文字列内では無効
        javascript = { "template_string" }, -- Javascriptのテンプレート文字列内では無効
        java = false, -- Javaでは無効
      },

      -- --------------------------------------
      -- Spaceの自動挿入
      -- --------------------------------------
      enable_check_bracket_line = true,

      -- --------------------------------------
      -- 移動の設定
      -- --------------------------------------
      enable_moveright = true, -- 閉じ括弧の後ろに移動
      enable_afterquote = true, -- クォートの後ろに移動

      -- --------------------------------------
      -- 無効化するファイルタイプ
      -- --------------------------------------
      disable_filetype = {
        "TelescopePrompt", -- Telescopeでは無効
      },

      -- --------------------------------------
      -- 無効化する入力モード
      -- --------------------------------------
      disable_in_macro = false, -- マクロ内でも有効
      disable_in_visualblock = false, -- ビジュアルブロックモードでも有効
      disable_in_replace_mode = true, -- 置換モードでは無効

      -- ----------------------------------------------------
      -- 隣接文字のパターン（この文字の隣では括弧補完しない）
      -- %w = 単語文字（a-z, A-Z, 0-9, _）
      -- %% = %文字
      -- %' = '文字
      -- %[ = [文字
      -- %" = "文字
      -- %. = .文字
      -- %` = `文字
      -- %$ = $文字
      -- ----------------------------------------------------
      ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],

      -- ----------------------------------------------------
      -- Fast Wrap機能
      -- Option+eで素早く括弧で囲む
      -- ----------------------------------------------------
      fast_wrap = {
        map = "<M-e>", -- Option+e
        chars = { "{", "[", "(", '"', "'" }, -- 使用する括弧の種類
        pattern = [=[[%'%"%>%]%)%}%,]]=], -- この文字の前で停止する（正規表現）
        end_key = "$", -- 行末まで囲む場合のキー
        keys = "qwertyuiopzxcvbnmasdfghjkl", -- 単語の選択に使うキー
        check_comma = true, -- カンマの前で停止する
        highlight = "Search", -- 選択時のハイライト（検索ハイライトと同じ色）
        highlight_grey = "Comment", -- その他の候補のハイライト（コメントと同じ色）
      }
    })

    -- ----------------------------------------------------
    -- nvim-cmpとの連携
    -- 補完候補を選択したときに自動で括弧を挿入する
    -- ----------------------------------------------------
    local cmp_autopairs = require("nvim-autopairs.completion.cmp") -- autopairsとcmpの連携モジュールを読み込む
    local cmp = require("cmp") -- cmpプラグインを読み込む
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done()) -- cmpの補完確定時にautopairsの処理を追加

    -- ----------------------------------------------------
    -- カスタムルール（高度な設定）
    -- ----------------------------------------------------
    local Rule = require("nvim-autopairs.rule") -- 新しいルールを定義
    local cond = require("nvim-autopairs.conds") -- 条件を定義するユーティリティ

    -- ---------------------------------------------------------
    -- Space挿入のカスタムルール
    -- 括弧の間でSpaceを入力したとき、両側にSpaceを入れる
    -- ---------------------------------------------------------
    autopairs.add_rules({
      -- ---------------------------------------------------------
      -- ルール1: Space -> Space
      -- 括弧ペアの間でSpaceを入力したとき
      -- ---------------------------------------------------------
      Rule(" ", " ")
        :with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col) -- カーソルの前後1文字を取得
          return vim.tbl_contains({ "()", "[]", "{}" }, pair)
        end),
      -- ---------------------------------------------------------
      -- ルール2: ( Space )の処理
      -- ( の後ろでSpaceを入力したとき
      -- ---------------------------------------------------------
      Rule("(", ")")
        :with_pair(function() return false end) -- ペアを作らない
        :with_move(function(opts)
          return opts.prev_char:match(".%)") ~= nil -- 前の文字が ) なら移動
        end)
        :use_key(")"), -- ) キーで発動
      -- ---------------------------------------------------------
      -- ルール3: { Space }の処理
      -- { の後ろでSpaceを入力したとき
      -- ---------------------------------------------------------
      Rule("{", "}")
        :with_pair(function() return false end) -- ペアを作らない
        :with_move(function(opts)
          return opts.prev_char:match(".%}") ~= nil -- 前の文字が } なら移動
        end)
        :use_key("}"), -- ) キーで発動
      -- ---------------------------------------------------------
      -- ルール4: [ Space ]の処理
      -- [ の後ろでSpaceを入力したとき
      -- ---------------------------------------------------------
      Rule("[", "]")
        :with_pair(function() return false end) -- ペアを作らない
        :with_move(function(opts)
          return opts.prev_char:match(".%]") ~= nil -- 前の文字が ] なら移動
        end)
        :use_key("]"), -- ) キーで発動
    })

    -- ---------------------------------------------------------
    -- 言語固有のカスタムルール
    -- 特定の言語でのみ適用されるルール
    -- ---------------------------------------------------------
    autopairs.add_rules({
      -- Rust: クロージャの | | を自動補完
      Rule("|", "|", "rust"),
      -- Markdown: コードブロックの ``` を自動補完。ただし、Enterキーでは補完しない
      Rule("```", "```", "markdown")
        :with_cr(function() return false end),
    })

    -- ---------------------------------------------------------
    -- Backspaceの挙動カスタマイズ
    -- 括弧ペアの間でBackspaceを押すと両方削除になる
    -- ---------------------------------------------------------
    vim.keymap.set("i", "<BS>", function()
      local col = vim.api.nvim_win_get_cursor(0)[2] -- 現在のカーソルの列番号を取得
      local line = vim.api.nvim_get_current_line() -- 現在行のテキストを取得
      local prev_char = line:sub(col, col) -- カーソルの前の文字を取得
      local next_char = line:sub(col + 1, col + 1) -- カーソルの次の文字を取得
      -- 括弧ペアの定義（開き括弧->閉じ括弧）
      local pairs = {
        ["("] = ")",
        ["["] = "]",
        ["{"] = "}",
        ['"'] = '"',
        ["'"] = "'",
        ["`"] = "`",
        ["<"] = ">",
      }
      -- 前の文字と次の文字が括弧ペアになっているかで挙動を分ける
      -- <Del> = 次の文字を削除、<BS> = 前の文字を削除
      if pairs[prev_char] == next_char then
        return "<Del><BS>" -- ペアの場合: 両方削除、
      else
        return "<BS>" -- ペアでない場合: 通常のBackspace
      end
    end, {
      expr = true, -- 式として評価（関数の戻り値を実行）
      noremap = true -- 再マッピングしない
    })
  end,
}
