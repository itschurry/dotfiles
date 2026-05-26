local loaded = false

local function setup()
  if loaded then
    return
  end
  loaded = true
  vim.cmd("packadd render-markdown.nvim")
  require("render-markdown").setup({})
end

vim.keymap.set("n", "<leader>mt", function()
  setup()
  vim.cmd("RenderMarkdown toggle")
end, {
  silent = true,
  desc = "Toggle markdown render",
})

vim.keymap.set("n", "<leader>mp", function()
  setup()
  vim.cmd("RenderMarkdown preview")
end, {
  silent = true,
  desc = "Preview markdown render",
})
