local group = vim.api.nvim_create_augroup("PersonalHelp", { clear = true })

-- :help는 편집 버퍼의 q를 바꾸지 않고 도움말 창에서만 닫기 키를 제공한다.
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "help",
  callback = function(event)
    vim.keymap.set("n", "q", "<cmd>quit<CR>", { buffer = event.buf, silent = true, desc = "Close help window" })
  end,
})

-- 현재 runtime systemd 도움말의 Vim 전용 ++close 인자는 Neovim에서
-- shell 명령으로 전달된다. 기존 옵션 조회 함수를 유지하고 인자만 제거한다.
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "systemd",
  callback = function(event)
    local command = vim.api.nvim_buf_get_commands(event.buf, {}).SystemdKeywordPrg
    if command and command.definition:find("term ++close", 1, true) then
      vim.api.nvim_buf_create_user_command(event.buf, "SystemdKeywordPrg", function(opts)
        vim.cmd("horizontal terminal " .. vim.fn.KeywordLookup_systemd(opts.args))
      end, { nargs = 1, desc = "Open systemd option manual" })
    end
  end,
})

local function is_help_terminal(name)
  local command = name:match("^term://.-//%d+:(.*)$") or ""
  -- man 직접 실행, runtime의 env MANPAGER 래퍼, Shell/Zsh keywordprg.
  -- 일반 shell/빌드 터미널에는 pager 키나 자동 닫기를 적용하지 않는다.
  return command:match("^%s*man%s")
    or command:match("^%s*/[^%s]+/man%s")
    or (command:match("^%s*env%s") and command:find("MANPAGER=", 1, true) and command:match("%sman%s"))
    or (command:match("^%s*bash%s+%-c%s") and command:find("help ", 1, true) and command:find("|| man ", 1, true))
    or (command:match("^%s*zsh%s+%-c%s") and command:find("run-help", 1, true))
end

local function close_help_terminal(buf)
  vim.schedule(function()
    if not vim.api.nvim_buf_is_valid(buf) then return end
    for _, win in ipairs(vim.fn.win_findbuf(buf)) do
      if #vim.api.nvim_list_wins() > 1 then
        vim.api.nvim_win_close(win, false)
      else
        local previous = vim.b[buf].personal_help_return_buf
        if previous and previous > 0 and previous ~= buf
          and vim.api.nvim_buf_is_valid(previous) and vim.bo[previous].buftype ~= "terminal" then
          vim.api.nvim_win_set_buf(win, previous)
        end
      end
    end
  end)
end

vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  callback = function(event)
    if not is_help_terminal(vim.api.nvim_buf_get_name(event.buf)) then return end
    vim.b[event.buf].personal_help_terminal = true
    vim.b[event.buf].personal_help_return_buf = vim.fn.bufnr("#")
    -- Normal에서도 pager 키를 전달한다. 짧은 builtin 도움말은 종료돼도
    -- 읽을 수 있도록 남겨 두고, q를 누른 경우에만 창을 닫는다.
    local function send(key)
      local job = vim.b[event.buf].terminal_job_id
      if key == "q" then vim.b[event.buf].personal_help_quit = true end
      if not job or vim.fn.jobwait({ job }, 0)[1] ~= -1 then
        if key == "q" then close_help_terminal(event.buf) end
        return
      end
      vim.api.nvim_chan_send(job, key)
      if key == "h" then vim.cmd("startinsert") end
    end
    for _, key in ipairs({ "h", "q" }) do
      vim.keymap.set("n", key, function() send(key) end,
        { buffer = event.buf, silent = true, nowait = true, desc = "Send " .. key .. " to help pager" })
    end
    vim.keymap.set("t", "q", function() send("q") end,
      { buffer = event.buf, silent = true, desc = "Quit help pager" })
    vim.schedule(function()
      if vim.api.nvim_get_current_buf() == event.buf then vim.cmd("startinsert") end
    end)
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  group = group,
  callback = function(event)
    if vim.b[event.buf].personal_help_terminal and vim.b[event.buf].personal_help_quit then
      close_help_terminal(event.buf)
    end
  end,
})
