-- SSH 옵션 도움말은 외부 less 터미널 대신 Neovim 내장 man 버퍼로 연다.
local group = vim.api.nvim_create_augroup("PersonalHelp", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "sshconfig",
  callback = function(event)
    vim.api.nvim_buf_create_user_command(event.buf, "SshOptionHelp", function(opts)
      vim.cmd("horizontal Man 5 ssh_config")
      -- 이름만 검색하므로 사용자 SSH 설정의 값은 도움말 명령에 전달하지 않는다.
      vim.fn.search([[^\s*\V]] .. vim.fn.escape(opts.args, [[\]]) .. [[\m\>]], "cw")
      vim.cmd("normal! zt")
    end, { nargs = 1, desc = "Open SSH option manual (q to close)" })
    vim.bo[event.buf].keywordprg = ":SshOptionHelp"
  end,
})
