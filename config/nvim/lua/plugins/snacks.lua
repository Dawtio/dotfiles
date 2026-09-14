return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true }, -- Don't load LSP or huge configuration for bigfile.
		dim = { enabled = true }, -- Will be useful for zen mode, show only current working portion of the code.
		explorer = { enabled = true }, -- Navigate through file at left of screen
		indent = { enabled = true }, -- Show line of current block
		input = { enabled = true }, -- Better UI for user request (rename, deletion, copy)
		picker = { -- Replacing telescope plugin
			enabled = true,
      win = {
        input = {
          keys = {
            ["<a-o>"] = { "opencode_send", mode = { "n", "i" } },
          },
        },
      },
      actions = {
        opencode_send = function(picker) ---@param picker snacks.Picker
          local items = vim.tbl_map(function(item) ---@param item snacks.picker.Item
            return item.file
              and require("opencode").format({ path = item.file, from = item.pos, to = item.end_pos })
              or item.text
          end, picker:selected({ fallback = true }))

          require("opencode").prompt(table.concat(items, ", ") .. " ")
        end,
      },
			layout = "custom",
			layouts = {
				custom = {
					layout = {
						box = "vertical",
						backdrop = false,
						row = -1,
						width = 0,
						height = 0.6,
						border = "rounded",
						title = " {title} {live} {flags}",
						title_pos = "left",
						{ win = "input", height = 1, border = "bottom" },
						{
							box = "horizontal",
							{ win = "list", border = "none" },
							{ win = "preview", title = "{preview}", width = 0.6, border = "left" },
						},
					},
				},
			},
		},
		notifier = { enabled = true, timeout = 3000 }, -- Show notification in a popout box instead of below
		quickfile = { enabled = true }, -- Render the file as quickly as possible
		scope = { enabled = true }, -- Scope detection based on treesitter or indent
		scroll = { enabled = true }, -- Smooth scrolling. Properly handle scrollof and mouse scrolling.
		words = { enabled = true }, -- Auto-show LSP references and quickly navigate between them.
		lazygit = { enabled = true }, -- Best git manager within nvim
		terminal = { -- Have a terminal integration
			enabled = true,
			keys = {
				q = "hide",
				gf = function(self)
					local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
					if f == "" then
						Snacks.notify.warn("No file under cursor")
					else
						self:hide()
						vim.schedule(function()
							vim.cmd("e " .. f)
						end)
					end
				end,
				term_normal = {
					"<esc>",
					function(self)
						self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
						if self.esc_timer:is_active() then
							self.esc_timer:stop()
							vim.cmd("stopinsert")
						else
							self.esc_timer:start(200, 0, function() end)
							return "<esc>"
						end
					end,
					mode = "t",
					expr = true,
					desc = "Double escape to normal mode",
				},
			},
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end

				-- Override print to use snacks for `:=` command
				if vim.fn.has("nvim-0.11") == 1 then
					vim._print = function(_, ...)
						dd(...)
					end
				else
					vim.print = _G.dd
				end

				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle.indent():map("<leader>ug")
				Snacks.toggle.dim():map("<leader>uD")
			end,
		})
	end,
}
