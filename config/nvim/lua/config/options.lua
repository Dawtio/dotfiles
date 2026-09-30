local opt = vim.opt

opt.relativenumber = false
opt.clipboard = "unnamedplus"
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.wrap = false
opt.number = true
opt.scrolloff = 8

vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN]  = "󰀪 ",
      [vim.diagnostic.severity.INFO]  = "󰋽 ",
      [vim.diagnostic.severity.HINT]  = "󰌶 ",
    },
  },
  virtual_lines = { current_line = true },
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = true,
  },
})
