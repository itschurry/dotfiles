vim.cmd("packadd nvim-treesitter")

local treesitter = require("nvim-treesitter")

treesitter.setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

local languages = {
  "c",
  "cpp",
  "cmake",
  "python",
  "dart",
  "dockerfile",
  "bash",
  "regex",
  "json",
  "yaml",
  "lua",
  "vim",
  "markdown",
  "markdown_inline",
  "http",
}

local filetype_languages = {
  sh = "bash",
  zsh = "bash",
}

local language_set = {}
for _, language in ipairs(languages) do
  language_set[language] = true
end

local autocmd_patterns = vim.tbl_keys(filetype_languages)
vim.list_extend(autocmd_patterns, languages)
table.sort(autocmd_patterns)

local function start_treesitter(buf)
  local filetype = vim.bo[buf].filetype
  local language = filetype_languages[filetype] or filetype
  if not language_set[language] then
    return
  end

  vim.treesitter.start(buf, language)
  vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

vim.api.nvim_create_user_command("TSInstallConfigured", function()
  if vim.fn.executable("tree-sitter") ~= 1 then
    error("tree-sitter CLI가 없어. 먼저 `npm install -g tree-sitter-cli` 또는 `cargo install tree-sitter-cli` 실행해.")
  end

  treesitter.install(languages, { force = true }):wait(300000)
end, { desc = "Install configured Treesitter parsers" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = autocmd_patterns,
  callback = function(args)
    start_treesitter(args.buf)
  end,
})

start_treesitter(vim.api.nvim_get_current_buf())

vim.api.nvim_set_hl(0, "@type", { link = "Type" })
vim.api.nvim_set_hl(0, "@type.builtin", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@namespace", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@class", { link = "Structure" })
vim.api.nvim_set_hl(0, "@struct", { link = "Structure" })
vim.api.nvim_set_hl(0, "@interface", { link = "Structure" })
vim.api.nvim_set_hl(0, "@enum", { link = "Structure" })
