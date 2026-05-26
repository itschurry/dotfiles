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

  dashboard.section.header.val = {
    "                                                      ",
    "                  Code. Build. Repeat.                ",
    "                                                      ",
  }
  dashboard.section.footer.val = {
    "                                                      ",
    "                  ┌─────────────────┐                 ",
    "                  │    ROBOTICS     │                 ",
    "                  └─────────────────┘                 ",
    "                                                      ",
  }

  dashboard.section.buttons.val = {
    dashboard.button("e", "📄 > 새 파 일 열 기", ":ene <BAR> startinsert <CR>"),
    dashboard.button("f", "🔎 > 파 일 찾 기", ":lua require('plugins.navigation.telescope').find_files()<CR>"),
    dashboard.button("r", "🗂️ > 최 근 파 일", ":lua require('plugins.navigation.telescope').oldfiles()<CR>"),
    dashboard.button("g", "🔍 > grep 문자열 찾기", ":lua require('plugins.navigation.telescope').live_grep()<CR>"),
    dashboard.button("a", "🚀 > Launch 파일 탐색", ":lua require('plugins.navigation.telescope').launch_files()<CR>"),
    dashboard.button("u", "⬆️ > 플러그인 업데이트", ":PlugUpdate<CR>"),
    dashboard.button("c", "⚙️ > Neovim 설정 열기", ":e ~/.config/nvim/init.lua<CR>"),
    dashboard.button("q", "❌>  종 료", ":qa<CR>"),
  }

  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Keyword"
  dashboard.section.footer.opts.hl = "Type"
  dashboard.opts.opts.noautocmd = true

  alpha.setup(dashboard.config)
end

function M.open()
  M.setup()
  vim.cmd("Alpha")
end

return M
