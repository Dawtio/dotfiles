return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    preset = "helix",
    spec = {
      {
	      mode = { "n", "x" },
	      { "<leader>a", group = "AI" },
	      { "<leader>f", group = "Find/File" },
	      { "<leader>g", group = "Git/Github" },
	      { "<leader>go", group = "Octohub" },
	      { "<leader>s", group = "Search" },
	      { "<leader>u", group = "UI/UX" },
        { "<leader>e", group = "Explorer" },
        { "<leader>n", group = "Notifications" },
        { "<leader>c", group = "Code" },
      }
    }
  },
  keys = {
    -- {
    --   "<leader>?",
    --   function()
    --     require("which-key").show({ global = false })
    --   end,
    --   desc = "Buffer Local Keymaps (which-key)",
    -- },
  },
}
