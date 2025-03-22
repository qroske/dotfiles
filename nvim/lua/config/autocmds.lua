-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local api = vim.api
local diagnostic = vim.diagnostic

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = api.nvim_create_augroup("float_diagnostic", { clear = true }),
  callback = function()
    diagnostic.open_float(nil, { focus = false })
  end,
})
