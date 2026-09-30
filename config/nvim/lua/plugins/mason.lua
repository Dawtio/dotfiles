return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  build = ":MasonUpdate",
  opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
    ensure_installed = {
      -- Add/remove servers you need here.
      -- Run :Mason to install/uninstall interactively.
      "lua_ls",
      "html",
      "yamlls",
      "terraformls",
      "stylua",
      "jqls",
      "jsonls",
      "gh_actions_ls",
      "dockerls",
    },
  },
  config = function(_, opts)
    require("mason").setup(opts)
    require("mason-lspconfig").setup({
      ensure_installed = opts.ensure_installed,
      automatic_installation = true,
    })
  end,
}
