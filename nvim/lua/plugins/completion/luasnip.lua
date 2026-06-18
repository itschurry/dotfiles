vim.cmd("packadd LuaSnip")

local ls = require("luasnip")
ls.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI", -- 실시간으로 갱신
  enable_autosnippets = true,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })
  end,
})

-- 키맵핑 예시
vim.keymap.set({ "i", "s" }, "<C-K>", function() ls.expand_or_jump() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

local s = ls.snippet
local t = ls.text_node

ls.add_snippets("cpp", {
  s("rosinfo", { t("RCLCPP_INFO(this->get_logger(), \"...\");") }),
  s("roswarn", { t("RCLCPP_WARN(this->get_logger(), \"...\");") }),
  s("roserr",  { t("RCLCPP_ERROR(this->get_logger(), \"...\");") }),
})
