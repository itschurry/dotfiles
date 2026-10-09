local o = vim.o
local wo = vim.wo

local bundled_lua_parser = vim.fn.fnamemodify(vim.v.progpath, ":h:h") .. "/lib/nvim/parser/lua.so"
if vim.fn.filereadable(bundled_lua_parser) == 1 then
  vim.treesitter.language.add("lua", { path = bundled_lua_parser })
end

-- 기본 옵션
o.encoding, o.fileencoding = "utf-8", "utf-8"
o.tabstop, o.shiftwidth, o.softtabstop = 4, 4, 4
o.expandtab, o.autoindent, o.smartindent = true, true, true
o.hidden, o.hlsearch, o.incsearch = true, true, true
o.ignorecase, o.smartcase = true, true
o.backspace = "indent,eol,start"
o.mouse = "a"
o.mousemoveevent = true
-- SSH에서는 로컬 터미널의 클립보드를 OSC 52로 사용한다.
if vim.env.SSH_CONNECTION and vim.env.SSH_CONNECTION ~= "" then
  vim.g.clipboard = "osc52"
end
o.clipboard = "unnamed,unnamedplus"
o.confirm = true
o.autoread = true
o.undofile = true
o.undodir = vim.fn.stdpath("state") .. "/undo//"
vim.fn.mkdir(vim.fn.stdpath("state") .. "/undo", "p")
o.splitbelow, o.splitright = true, true
o.wrap = false
o.list = true
o.listchars = "tab:» ,trail:·,nbsp:␣"
o.timeoutlen = 400
o.updatetime = 250

-- 줄 번호
wo.number, wo.relativenumber = true, true

-- 색상과 현재 줄을 또렷하게 표시하고 gutter 폭을 고정
o.termguicolors = true
o.background = "dark"
wo.cursorline = true
o.cursorlineopt = "number,line"
wo.signcolumn = "yes:1"
o.numberwidth = 4
o.pumblend, o.winblend = 0, 0
o.winborder = "rounded"
o.laststatus = 3
o.fillchars = "eob: "

-- 탐색 중 커서 주변 문맥 유지
o.scrolloff, o.sidescrolloff = 5, 5
