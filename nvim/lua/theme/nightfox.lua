vim.cmd("packadd nightfox.nvim")

require("nightfox").setup({
  options = {
    transparent = true,
    terminal_colors = true,
    dim_inactive = true,
    styles = { comments = "italic",
      keywords = "NONE",
      functions = "bold",
      variables = "NONE",
    },
    inverse = {
      match_paren = false,
      visual = false,
      search = false,
    },
  },
  groups = {
    all = {
      LineNr = { fg = "palette.blue" },
      CursorLineNr = { fg = "palette.orange", style = "bold" },
      Visual = { bg = "#334155" },
      Search = { fg = "palette.bg1", bg = "palette.orange", style = "bold" },
    },
  },
})

vim.cmd("colorscheme terafox")
