return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      rust_analyzer = {
        cmd = { vim.fn.trim(vim.fn.system("mise which rust-analyzer")) },
      },
    },
  },
}
