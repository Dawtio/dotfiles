return {
	"2kabhishek/octohub.nvim",
	cmd = { "Octohub" },
	keys = { "<leader>goo" }, -- Add more bindings as needed
	dependencies = {
		"2kabhishek/utils.nvim",
		"2kabhishek/pickme.nvim",
	},
	-- Add your custom configs here, keep it blank for default configs (required)
	opts = {
    repos = {
      projects_dir = '~/Projects', -- Directory where repositories are cloned.
    }
  },
}
