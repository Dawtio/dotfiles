return {
  "saghen/blink.cmp",
  version = "*", -- required for pre-built binaries (no Rust toolchain needed)
  opts = {
    keymap = {
      preset = "default",
      -- Enter to confirm, Tab to select next
      ["<CR>"]  = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      menu = {
        draw = {
          -- Show a kind icon + label + source name in the menu
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
        },
      },
    },
  },
}
