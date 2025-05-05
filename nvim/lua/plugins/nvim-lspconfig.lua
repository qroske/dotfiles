return {
  -- disable mason-lspconfig
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  -- setup nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local servers = opts.servers or {}
      -- settings rust-analyzer
      vim.fn.systemlist({ "mise", "which", "rust-analyzer" })
      if vim.v.shell_error == 0 then
        servers.rust_analyzer = {
          cmd = { vim.fn.trim(vim.fn.system("mise which rust-analyzer")) },
          filetypes = { "rust" },
        }
      end
      -- settings biome
      vim.fn.systemlist({ "mise", "which", "npx" })
      if vim.v.shell_error == 0 then
        servers.biome = {
          cmd = { vim.fn.trim(vim.fn.system("mise which npx")), "biome", "lsp-proxy" },
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json" },
        }
      end
      opts.servers = servers
    end,
  },
}
