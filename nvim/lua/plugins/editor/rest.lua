local function add_luarocks_path()
  local rocks_root = vim.fn.stdpath("data") .. "/rocks"
  package.path = table.concat({
    rocks_root .. "/share/lua/5.1/?.lua",
    rocks_root .. "/share/lua/5.1/?/init.lua",
    package.path,
  }, ";")
  package.cpath = table.concat({
    rocks_root .. "/lib/lua/5.1/?.so",
    package.cpath,
  }, ";")
end

vim.filetype.add({
  extension = {
    http = "http",
    rest = "http",
  },
})

local loaded = false

local function setup()
  if loaded then
    return
  end
  loaded = true

  add_luarocks_path()
  vim.g.rest_nvim = {
    request = {
      skip_ssl_verification = false,
    },
  }

  vim.cmd("packadd nvim-nio")
  vim.cmd("packadd fidget.nvim")
  vim.cmd("packadd rest.nvim")
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "http",
  callback = setup,
})

vim.keymap.set("n", "<leader>rr", function()
  setup()
  vim.cmd("Rest run")
end, { silent = true, desc = "Run REST request under cursor" })

vim.keymap.set("n", "<leader>rl", function()
  setup()
  vim.cmd("Rest last")
end, { silent = true, desc = "Run last REST request" })

vim.keymap.set("n", "<leader>re", function()
  setup()
  vim.cmd("Rest env select")
end, { silent = true, desc = "Select REST env file" })
