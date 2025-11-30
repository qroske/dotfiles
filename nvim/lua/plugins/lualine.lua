-- --------------------------------
-- lualine.nvim: ステータスライン
-- --------------------------------
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim", -- gitsignsとの連携
  },
  -- neo-treeやgitsignsの後に読み込む
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        -- テーマ（カラースキームに自動で合わせる）
        -- 他のオプション: 'gruvbox', 'tokyonight', 'catppuccin' など
        theme = "auto",

        -- アイコンによる区切り（より美しい見た目）
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },

        -- ステータスラインを常に表示
        globalstatus = true, -- 分割ウィンドウでも1つのステータスライン

        -- neo-treeなどの特殊バッファでは簡易表示
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
      },

      sections = {
        -- ========================================
        -- 左側セクション
        -- ========================================

        -- セクションA: モード表示（色分けされる）
        lualine_a = {
          {
            'mode',
          }
        },

        -- セクションB: Git情報（gitsignsと連携）
        lualine_b = {
          {
            'branch',
            icon = '', -- Gitブランチアイコン
          },
          {
            'diff',
            -- gitsignsから差分情報を取得
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed
                }
              end
            end,
            -- 差分の色設定
            symbols = {
              added = ' ',
              modified = ' ',
              removed = ' '
            },
            diff_color = {
              added = { fg = '#98c379' },    -- 緑
              modified = { fg = '#e5c07b' }, -- 黄
              removed = { fg = '#e06c75' },  -- 赤
            },
          },
          {
            'diagnostics',
            -- LSPの診断情報（エラー、警告など）
            sources = { 'nvim_lsp', 'nvim_diagnostic' },
            sections = { 'error', 'warn', 'info', 'hint' },
            symbols = {
              error = ' ',
              warn = ' ',
              info = ' ',
              hint = ' ',
            },
          },
        },

        -- セクションC: ファイル名
        lualine_c = {
          {
            'filename',
            file_status = true,     -- 変更状態を表示（[+]など）
            newfile_status = true,  -- 新規ファイルを表示
            path = 1,               -- 0=ファイル名のみ, 1=相対パス, 2=絶対パス
            shorting_target = 40,   -- パスを短縮する長さ
            symbols = {
              modified = '[+]',      -- 変更あり
              readonly = '[-]',      -- 読み取り専用
              unnamed = '[No Name]', -- 無名バッファ
              newfile = '[New]',     -- 新規ファイル
            },
          },
        },

        -- ========================================
        -- 右側セクション
        -- ========================================

        -- セクションX: ファイル情報
        lualine_x = {
          {
            'encoding',
          },
          {
            'fileformat',
            symbols = {
              unix = 'LF',
              dos = 'CRLF',
              mac = 'CR',
            },
          },
          {
            'filetype',
            icon_only = false, -- アイコンとファイルタイプ名を表示
          },
        },

        -- セクションY: ファイル内の位置（パーセント）
        lualine_y = {
          {
            'progress',
            -- "75%"のような表示
          }
        },

        -- セクションZ: カーソル位置（行:列）
        lualine_z = {
          {
            'location',
            -- "127:12"のような表示（行:列）
          }
        },
      },

      -- 非アクティブウィンドウのステータスライン
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },

      -- タブラインの設定（オプション）
      -- 複数のタブを使う場合に便利
      tabline = {},

      -- 特定のファイルタイプでの拡張設定
      extensions = {
        'neo-tree',    -- neo-tree使用時の最適化
        'lazy',        -- lazy.nvim使用時
        'toggleterm', -- ターミナル使用時（入れている場合）
      }
    })
  end,
}
