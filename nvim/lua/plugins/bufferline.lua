-- --------------------------------
-- bufferline.nvim: タブ表示
-- --------------------------------
return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim", -- gitsignsとの連携
  },
  -- neo-treeやgitsignsの後に読み込む
  event = "VeryLazy",
  config = function()
    require("bufferline").setup({
      options = {
        -- ========================================
        -- 基本設定
        -- ========================================

        -- タブのスタイル
        mode = "buffers", -- 'buffers' | 'tabs'

        -- タブを閉じるコマンド
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",

        -- ========================================
        -- 見た目の設定
        -- ========================================

        -- アクティブなタブのインジケーター
        indicator = {
          icon = '▎',
          style = 'icon', -- 'icon' | 'underline' | 'none'
        },

        -- アイコン設定
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',

        -- タブの表示設定
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 20,

        -- ========================================
        -- gitsignsとの連携
        -- ========================================

        -- LSPの診断情報を表示（エラー、警告など）
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        -- エラーがある場合にアイコン表示
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,

        -- ========================================
        -- neo-treeとの連携（重要）
        -- ========================================

        -- neo-treeのためのオフセット設定
        -- neo-treeを開いているときに、タブがずれて表示される
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer", -- 表示するテキスト
            text_align = "center",  -- 'left' | 'center' | 'right'
            separator = true,       -- セパレーターを表示
            highlight = "Directory",
          }
        },

        -- neo-treeなど特殊なバッファをタブに表示しない
        custom_filter = function(buf_number, buf_numbers)
          -- neo-tree、toggleterm、helpなどを除外
          local filetype = vim.bo[buf_number].filetype
          local buftype = vim.bo[buf_number].buftype

          -- 除外するファイルタイプ
          local exclude_ft = {
            "neo-tree",
            "toggleterm",
            "TelescopePrompt",
            "help",
            "qf",
            "lazy",
          }

          for _, ft in ipairs(exclude_ft) do
            if filetype == ft then
              return false
            end
          end

          -- 特殊なバッファタイプを除外
          if buftype == "terminal" or buftype == "quickfix" then
            return false
          end

          return true
        end,

        -- ========================================
        -- 表示オプション
        -- ========================================

        -- アイコンと色
        color_icons = true,              -- ファイルタイプごとの色分け
        show_buffer_icons = true,        -- ファイルアイコンを表示
        show_buffer_close_icons = false,  -- 各タブに閉じるボタン
        show_close_icon = false,          -- 右端に閉じるボタン
        show_tab_indicators = true,      -- タブインジケーター
        show_duplicate_prefix = true,    -- 重複ファイル名のディレクトリ表示
        persist_buffer_sort = true,      -- ソート順を保持

        -- セパレーターのスタイル
        separator_style = "thick", -- 'slant' | 'slope' | 'thick' | 'thin'

        -- 常にバッファラインを表示
        always_show_bufferline = true,

        -- ========================================
        -- ソートとグループ化
        -- ========================================

        -- ソート方法（新しいバッファを現在のバッファの後に挿入）
        sort_by = 'insert_after_current',

        -- グループ化（オプション：ファイルタイプごとにグループ化）
        groups = {
          options = {
            toggle_hidden_on_enter = true
          },
          items = {
            {
              name = "Tests",
              highlight = { underline = true, sp = "blue" },
              priority = 2,
              icon = "",
              matcher = function(buf)
                return buf.name:match('%_test') or buf.name:match('%_spec')
              end,
            },
            {
              name = "Docs",
              highlight = { underline = true, sp = "green" },
              auto_close = false,
              matcher = function(buf)
                return buf.name:match('%.md') or buf.name:match('%.txt')
              end,
            },
          }
        },
      },

      -- ========================================
      -- ハイライトのカスタマイズ（オプション）
      -- ========================================
      highlights = {
        -- アクティブなバッファ
        buffer_selected = {
          bold = true,
          italic = false,
        },
        -- 変更されたバッファ
        modified_selected = {
          bold = false,
          italic = true,
        },
        -- 診断情報（エラー）
        error_diagnostic_selected = {
          bold = false,
          italic = false,
        },
      },
    })

    -- ========================================
    -- キーマップ設定
    -- ========================================

    -- タブの移動
    vim.keymap.set('n', '<Tab>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })
    vim.keymap.set('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Previous buffer' })

    -- Altキー（Macの場合はOption）での移動も便利
    vim.keymap.set('n', '<A-l>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })
    vim.keymap.set('n', '<A-h>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Previous buffer' })

    -- タブを番号で直接移動（<leader> + 数字）
    vim.keymap.set('n', '<leader>1', '<cmd>BufferLineGoToBuffer 1<cr>', { desc = 'Go to buffer 1' })
    vim.keymap.set('n', '<leader>2', '<cmd>BufferLineGoToBuffer 2<cr>', { desc = 'Go to buffer 2' })
    vim.keymap.set('n', '<leader>3', '<cmd>BufferLineGoToBuffer 3<cr>', { desc = 'Go to buffer 3' })
    vim.keymap.set('n', '<leader>4', '<cmd>BufferLineGoToBuffer 4<cr>', { desc = 'Go to buffer 4' })
    vim.keymap.set('n', '<leader>5', '<cmd>BufferLineGoToBuffer 5<cr>', { desc = 'Go to buffer 5' })
    vim.keymap.set('n', '<leader>6', '<cmd>BufferLineGoToBuffer 6<cr>', { desc = 'Go to buffer 6' })
    vim.keymap.set('n', '<leader>7', '<cmd>BufferLineGoToBuffer 7<cr>', { desc = 'Go to buffer 7' })
    vim.keymap.set('n', '<leader>8', '<cmd>BufferLineGoToBuffer 8<cr>', { desc = 'Go to buffer 8' })
    vim.keymap.set('n', '<leader>9', '<cmd>BufferLineGoToBuffer 9<cr>', { desc = 'Go to buffer 9' })
    vim.keymap.set('n', '<leader>0', '<cmd>BufferLineGoToBuffer -1<cr>', { desc = 'Go to last buffer' })

    -- タブを閉じる
    vim.keymap.set('n', '<leader>bc', '<cmd>bdelete<cr>', { desc = 'Close current buffer' })
    vim.keymap.set('n', '<leader>bx', '<cmd>bdelete!<cr>', { desc = 'Force close buffer' })

    -- 他のタブを閉じる
    vim.keymap.set('n', '<leader>bo', '<cmd>BufferLineCloseOthers<cr>', { desc = 'Close other buffers' })

    -- 右側/左側のタブをすべて閉じる
    vim.keymap.set('n', '<leader>br', '<cmd>BufferLineCloseRight<cr>', { desc = 'Close buffers to the right' })
    vim.keymap.set('n', '<leader>bl', '<cmd>BufferLineCloseLeft<cr>', { desc = 'Close buffers to the left' })

    -- タブの並び替え
    vim.keymap.set('n', '<A-S-l>', '<cmd>BufferLineMoveNext<cr>', { desc = 'Move buffer right' })
    vim.keymap.set('n', '<A-S-h>', '<cmd>BufferLineMovePrev<cr>', { desc = 'Move buffer left' })

    -- ピン留め（固定）- 閉じられないようにする
    vim.keymap.set('n', '<leader>bp', '<cmd>BufferLineTogglePin<cr>', { desc = 'Toggle pin buffer' })

    -- バッファをピッカーで選択（インタラクティブ選択）
    vim.keymap.set('n', '<leader>bb', '<cmd>BufferLinePick<cr>', { desc = 'Pick buffer' })

    -- バッファを閉じるピッカー
    vim.keymap.set('n', '<leader>bD', '<cmd>BufferLinePickClose<cr>', { desc = 'Pick buffer to close' })

    -- グループ化されたバッファを閉じる
    vim.keymap.set('n', '<leader>bgr', '<cmd>BufferLineGroupClose ungrouped<cr>', { desc = 'Close ungrouped buffers' })
    vim.keymap.set('n', '<leader>bgt', '<cmd>BufferLineGroupToggle Tests<cr>', { desc = 'Toggle Tests group' })
    vim.keymap.set('n', '<leader>bgd', '<cmd>BufferLineGroupToggle Docs<cr>', { desc = 'Toggle Docs group' })
  end,
}
