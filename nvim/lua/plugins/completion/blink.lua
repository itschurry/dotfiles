require("plugins.completion.luasnip")

require("blink.cmp").setup({
  keymap = {
    preset = "enter",
    ["<C-s>"] = { "show", "show_documentation", "hide_documentation" },
    ["<Tab>"] = { "select_next" },
    ["<S-Tab>"] = { "select_prev" },
  },
  snippets = { preset = "luasnip" },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  completion = {
    documentation = { auto_show = false },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning",
  },
})

require("nvim-autopairs").setup({
  check_ts = true,
  disable_filetype = { "TelescopePrompt", "vim" },
})
