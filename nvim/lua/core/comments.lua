local M = {}

-- 파일 이름/경로가 문법을 명확하게 지정하는 경우만 보완한다.
vim.filetype.add({
  filename = { [".clangd"] = "yaml", [".clang-format"] = "yaml" },
  pattern = {
    [".*/%.ssh/config%.d/.*"] = "sshconfig",
    [".*/%.env%.[%w_-]+"] = "env",
  },
})

function M.choose_filetype()
  local buf = vim.api.nvim_get_current_buf()
  local choices = { "sh", "python", "lua", "sshconfig", "yaml", "toml", "dosini", "conf", "gitconfig", "env", "javascript", "typescript", "jsonc", "html", "css", "markdown", "cpp" }
  vim.ui.select(choices, { prompt = "파일의 실제 문법 선택 (이 버퍼만 적용)" }, function(ft)
    if ft and vim.api.nvim_buf_is_valid(buf) then
      vim.bo[buf].filetype = ft
      vim.notify("파일 형식: " .. ft .. ". 주석 키를 다시 누르세요. 디스크 내용은 변경하지 않았습니다.")
    end
  end)
end

local function comment_keys(keys)
  if vim.bo.filetype == "json" then
    vim.schedule(function()
      vim.notify("JSON은 주석을 허용하지 않습니다. 실제 형식이 JSONC인 경우에만 ,ft 또는 :setlocal filetype=jsonc로 선택하세요.", vim.log.levels.WARN)
    end)
    return ""
  end
  if vim.bo.commentstring == "" or not vim.bo.commentstring:find("%%s") then
    vim.schedule(function()
      vim.notify("주석 문법을 알 수 없습니다. 파일의 실제 형식을 ,ft 또는 :setlocal filetype=<형식>으로 선택하세요.", vim.log.levels.WARN)
    end)
    return ""
  end
  return keys
end

function M.setup()
  -- Neovim 내장 gc/gcc를 사용해 Treesitter 없이도 commentstring으로 동작한다.
  for _, key in ipairs({ "<leader>/", "<M-/>" }) do
    vim.keymap.set("n", key, function() return comment_keys("gcc") end,
      { expr = true, remap = true, desc = "Toggle comment" })
    vim.keymap.set("x", key, function() return comment_keys("gc") end,
      { expr = true, remap = true, desc = "Toggle selected lines comment" })
  end
  vim.keymap.set("n", "<leader>ft", M.choose_filetype, { desc = "Choose buffer filetype" })
end

return M
