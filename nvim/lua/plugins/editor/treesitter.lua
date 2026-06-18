local treesitter = require("nvim-treesitter")

treesitter.setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

local languages = {
  "c",
  "cpp",
  "cmake",
  "python",
  "dockerfile",
  "bash",
  "regex",
  "json",
  "yaml",
  "lua",
  "vim",
  "markdown",
  "markdown_inline",
}

vim.api.nvim_create_user_command("TSInstallConfigured", function()
  if vim.fn.executable("tree-sitter") ~= 1 then
    error("tree-sitter CLI가 없어. 먼저 `npm install -g tree-sitter-cli` 또는 `cargo install tree-sitter-cli` 실행해.")
  end

  treesitter.install(languages):wait(300000)
end, { desc = "Install configured Treesitter parsers" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = languages,
  callback = function()
    vim.treesitter.start()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.api.nvim_set_hl(0, "@type", { link = "Type" })
vim.api.nvim_set_hl(0, "@type.builtin", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@namespace", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@class", { link = "Structure" })
vim.api.nvim_set_hl(0, "@struct", { link = "Structure" })
vim.api.nvim_set_hl(0, "@interface", { link = "Structure" })
vim.api.nvim_set_hl(0, "@enum", { link = "Structure" })
