local M = {}
local loaded = false

function M.setup()
  if loaded then
    return
  end
  loaded = true
  vim.cmd("packadd alpha-nvim")

  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")

  local function button(sc, txt, cmd)
    return dashboard.button(sc, txt, cmd)
  end

  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
  local version = "v" .. table.concat({
    vim.version().major,
    vim.version().minor,
    vim.version().patch,
  }, ".")

  dashboard.section.header.val = {
    "                 ˚ .  ｡  *  ˚  .  ｡  *  ˚  .  ｡  *  ˚  .  ｡  *",
    "",
    "  ___ _____ ____   ____ _   _ _   _ ____  ______   __   _        _    ____",
    " |_ _|_   _/ ___| / ___| | | | | | |  _ \\|  _ \\ \\ / /  | |      / \\  | __ )",
    "  | |  | | \\___ \\| |   | |_| | | | | |_) | |_) \\ V /   | |     / _ \\ |  _ \\",
    "  | |  | |  ___) | |___|  _  | |_| |  _ <|  _ < | |    | |___ / ___ \\| |_) |",
    " |___| |_| |____/ \\____|_| |_|\\___/|_| \\_\\_| \\_\\|_|    |_____/_/   \\_\\____/",
    "",
    "                               No mouse, No mercy",
    "",
    "                  .  ˚  *  ｡  .  ˚  *  ｡  .  ˚  *  ｡  .  ˚  *  ｡",
  }

  dashboard.section.footer.val = {
    "",
    "  " .. version .. "  |  " .. cwd,
    "  ,ff find  ,fg grep  <C-n> tree  <C-t> symbols",
  }

  dashboard.section.buttons.val = {
    button("e", "     새 파일        ", ":ene <BAR> startinsert<CR>"),
    button("f", "     파일 찾기      ", ":lua require('plugins.navigation.telescope').find_files()<CR>"),
    button("r", "     최근 파일      ", ":lua require('plugins.navigation.telescope').oldfiles()<CR>"),
    button("g", "  󰱼   문자열 검색    ", ":lua require('plugins.navigation.telescope').live_grep()<CR>"),
    button("a", "  󰑮   launch 탐색    ", ":lua require('plugins.navigation.telescope').launch_files()<CR>"),
    button("u", "     플러그인 갱신  ", ":PlugUpdate<CR>"),
    button("c", "     설정 열기      ", ":e ~/.config/nvim/init.lua<CR>"),
    button("q", "  󰩈   종료           ", ":qa<CR>"),
  }

  dashboard.section.header.opts.hl = "AlphaHeader"
  dashboard.section.buttons.opts.hl = "AlphaButtons"
  dashboard.section.footer.opts.hl = "AlphaFooter"
  dashboard.config.layout = {
    { type = "padding", val = 2 },
    dashboard.section.header,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    { type = "padding", val = 1 },
    dashboard.section.footer,
  }

  vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#f4b8e4", bold = true })
  vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#c0caf5" })
  vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#94e2d5", italic = true })
  dashboard.opts.opts.noautocmd = true

  alpha.setup(dashboard.config)
end

function M.open()
  M.setup()
  vim.cmd("Alpha")
end

return M
