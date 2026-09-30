return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "lua",
      "yaml",
      "markdown",
      "markdown_inline"
    },
    highlight = { enable = true },
    indent = { enable = true },
  },
}
