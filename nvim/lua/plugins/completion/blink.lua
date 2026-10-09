vim.cmd("packadd blink.cmp")
vim.cmd("packadd nvim-autopairs")

require("plugins.completion.luasnip")

require("blink.cmp").setup({
  keymap = {
    preset = "enter",
    ["<C-s>"] = {}, -- Ctrl+s는 저장, 완성창은 Ctrl+Space
    ["<C-k>"] = {}, -- LuaSnip의 다음 항목 이동 유지
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
    ["<Up>"] = {},
    ["<Down>"] = {},
    ["<C-n>"] = { "select_next" },
    ["<C-p>"] = { "select_prev" },
  },
  snippets = { preset = "luasnip" },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  completion = {
    list = {
      selection = { preselect = false, auto_insert = false },
    },
    menu = {
      border = "rounded",
      max_height = 10,
      draw = {
        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 250,
      window = { border = "rounded" },
    },
  },
  fuzzy = {
    implementation = "rust",
  },
})

require("nvim-autopairs").setup({
  check_ts = true,
  disable_filetype = { "TelescopePrompt", "vim" },
})
