vim.cmd("packadd tokyonight.nvim")

require("tokyonight").setup({
  style = "night", -- night | storm | moon | day 중 선택
  transparent = false, -- 터미널 배경과 관계없이 테마 배경색 유지
  terminal_colors = true, -- 터미널 색상도 변경

  styles = {
    comments = { italic = false }, -- 주석도 평문으로 읽기 쉽게
    keywords = { italic = false }, -- 키워드는 강조 대신 또렷하게
    functions = {},
    variables = {},
    sidebars = "dark",
    floats = "dark",
  },

  sidebars = { "qf", "help", "terminal", "packer", "NvimTree" }, -- 밝기 낮추는 사이드바
  dim_inactive = false, -- 분할 창에서도 동일한 코드 대비 유지
  lualine_bold = true, -- lualine 텍스트를 굵게

  on_colors = function(c)
    c.comment = "#8892b0"
    c.fg_sidebar = c.fg
  end,

  on_highlights = function(hl, c)
    hl.LineNr = { fg = "#737da2" }
    hl.CursorLineNr = { fg = c.blue, bold = true }
    hl.CursorLine = { bg = c.bg_highlight }
    hl.CursorLineSign = { bg = c.bg }
    hl.WinSeparator = { fg = c.bg_highlight, bg = c.bg }
    hl.NvimTreeWinSeparator = { fg = c.bg_highlight, bg = c.bg_dark }
    hl.IblIndent = { fg = "#292e42" }
    hl.IblScope = { fg = "#545c7e" }
    hl.Visual = { bg = "#334155" } -- 선택 영역 색상
    hl.Search = { fg = c.bg, bg = c.orange, bold = true }
  end,
})

vim.cmd("colorscheme tokyonight")
