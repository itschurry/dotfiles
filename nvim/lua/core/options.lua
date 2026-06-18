local o = vim.o
local wo = vim.wo
local g = vim.g

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
o.mouse = ""
o.clipboard = "unnamed,unnamedplus"

-- 줄 번호
wo.number, wo.relativenumber = true, true
