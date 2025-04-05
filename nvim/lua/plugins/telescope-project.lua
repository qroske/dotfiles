return {
  "nvim-telescope/telescope-project.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      extensions = {
        project = {
          theme = "dropdown", -- テーマ設定
          order_by = "recent", -- 最近開いた順にソート
          on_project_selected = function(prompt_bufnr)
            -- プロジェクトのディレクトリを変更
            require("telescope._extensions.project.actions").change_working_directory(prompt_bufnr, false)
            -- Neotreeを現在のディレクトリで開く
            vim.cmd("Neotree " .. require("telescope.actions.state").get_selected_entry().path)
          end,
        },
      },
    })

    telescope.load_extension("project")
  end,
}
