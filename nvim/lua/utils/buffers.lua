local M = {}

-- 버퍼를 지우기 전에 표시 중인 창의 내용을 교체해 분할과 트리 폭을 유지한다.
function M.close(buf)
  buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
  if vim.bo[buf].filetype == "NvimTree" then return end

  local discard = false
  if vim.bo[buf].modified then
    local name = vim.api.nvim_buf_get_name(buf)
    local choice = vim.fn.confirm(
      (name ~= "" and name or "[이름 없음]") .. " 변경 내용을 저장할까?",
      "저장(&S)\n버리기(&D)\n취소(&C)", 3
    )
    if choice == 1 then
      vim.api.nvim_buf_call(buf, function() vim.cmd("write") end)
      if vim.bo[buf].modified then return end
    elseif choice == 2 then
      discard = true
    else
      return
    end
  end

  local function is_edit_buffer(candidate)
    return candidate > 0 and candidate ~= buf
      and vim.api.nvim_buf_is_valid(candidate)
      and vim.bo[candidate].buflisted and vim.bo[candidate].buftype == ""
  end

  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.api.nvim_win_call(win, function()
      local next_buf = vim.fn.bufnr("#")
      if not is_edit_buffer(next_buf) then
        next_buf = nil
        for _, candidate in ipairs(vim.api.nvim_list_bufs()) do
          if is_edit_buffer(candidate) then
            next_buf = candidate
            break
          end
        end
      end
      -- 마지막 파일을 닫아도 빈 편집 버퍼를 남긴다.
      next_buf = next_buf or vim.api.nvim_create_buf(true, false)
      vim.api.nvim_win_set_buf(win, next_buf)
    end)
  end

  -- bufhidden=wipe/delete인 버퍼는 창에서 교체하는 순간 이미 제거될 수 있다.
  if vim.api.nvim_buf_is_valid(buf) and (vim.bo[buf].buflisted or vim.fn.bufloaded(buf) == 1) then
    vim.api.nvim_buf_delete(buf, { force = discard })
  end
end

return M
