local M = {}
local loaded = false

function M.setup()
  if loaded then
    return
  end
  loaded = true
  vim.cmd("packadd telescope.nvim")

  local telescope = require("telescope")
  local actions = require("telescope.actions")

  telescope.setup({
    defaults = {
      file_ignore_patterns = { "node_modules", ".git", "build", "install" },
      mappings = {
        i = {
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,
        },
      },
    },
  })
end

local function builtin(name, opts)
  M.setup()
  require("telescope.builtin")[name](opts or {})
end

-- Telescope 명령어에 키맵 연결
local map = vim.keymap.set
map("n", "<leader>ff", function() builtin("find_files") end, { silent = true })
map("n", "<leader>fF", function() builtin("git_files") end, { silent = true })
map("n", "<leader>fg", function() builtin("live_grep") end, { silent = true })
map("n", "<leader>fb", function() builtin("buffers") end, { silent = true })
map("n", "<leader>fh", function() builtin("help_tags") end, { silent = true })
map("n", "<leader>fo", function() builtin("oldfiles") end, { silent = true })
map("n", "<leader>fs", function() builtin("lsp_document_symbols") end, { silent = true })
map("n", "<leader>fr", function() builtin("lsp_references") end, { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>ff', '<Cmd>Telescope find_files<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fg', '<Cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fb', '<Cmd>Telescope buffers<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fh', '<Cmd>Telescope help_tags<CR>', { noremap = true, silent = true })


-- Fuction for selecting buffers and performing vimdiff
function M.diff_buffers()
    M.setup()
    require('telescope.builtin').buffers {
        attach_mappings = function(_, map)
            local actions = require('telescope.actions')
            local state = require('telescope.actions.state')

            local buffer_seclection = {}

            map('i', '<CR>', function(prompt_bufnr)
                local selection = state.get_selected_entry()
                table.insert(buffer_seclection, selection.bufnr)

                if #buffer_seclection == 2 then
                    actions.close(prompt_bufnr)
                    vim.cmd('vsplit')
                    vim.cmd('buffer ' .. buffer_seclection[1])
                    vim.cmd('diffthis')
                    vim.cmd('wincmd w')
                    vim.cmd('buffer ' .. buffer_seclection[2])
                    vim.cmd('diffthis')
                else
                    actions.move_selection_next(prompt_bufnr)
                end
            end)
            return true
        end
    }
end
vim.keymap.set("n", "<leader>fd", M.diff_buffers, { silent = true })

function M.find_files()
  builtin("find_files")
end

function M.git_files()
  builtin("git_files")
end

function M.live_grep()
  builtin("live_grep")
end

function M.oldfiles()
  builtin("oldfiles")
end

function M.launch_files()
  builtin("find_files", { search_dirs = { "src" }, prompt_title = "launch" })
end

function M.diagnostics()
  builtin("diagnostics")
end

return M
