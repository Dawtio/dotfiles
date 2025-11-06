return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      xml = { "xmllint" },
      tf = { "terraform_fmt" },
      yaml = { "yamlfmt" },
    },
    formatters = {
      xmllint = {
        prepend_args = { "--format" },
      },
    },
  },
}
