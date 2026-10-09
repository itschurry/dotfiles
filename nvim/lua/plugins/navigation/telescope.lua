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
      file_ignore_patterns = { "^node_modules/", "/node_modules/", "^%.git/", "/%.git/", "^build/", "/build/", "^install/", "/install/", "^log/", "/log/", "^%.venv/", "/%.venv/" },
      sorting_strategy = "ascending",
      layout_strategy = "flex",
      layout_config = {
        width = 0.9,
        height = 0.85,
        prompt_position = "top",
        horizontal = { preview_width = 0.55 },
        vertical = { preview_height = 0.45 },
      },
      path_display = { "smart" },
      border = true,
      mappings = {
        i = {
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,
          ["<Esc>"] = actions.close,
        },
      },
    },
    pickers = {
      find_files = { hidden = true },
      live_grep = { additional_args = { "--hidden", "--glob", "!.git/*" } },
      grep_string = { additional_args = { "--hidden", "--glob", "!.git/*" } },
      buffers = { sort_mru = true },
    },
  })
end

local function builtin(name, opts)
  M.setup()
  require("telescope.builtin")[name](opts or {})
end

-- Telescope 명령어에 키맵 연결
local map = vim.keymap.set
map("n", "<leader>ff", function() builtin("find_files") end, { silent = true, desc = "Find files" })
map("n", "<leader>fF", function() builtin("git_files") end, { silent = true, desc = "Find Git files" })
map("n", "<leader>fg", function() builtin("live_grep") end, { silent = true, desc = "Search project text" })
map("n", "<leader>fw", function() builtin("grep_string") end, { silent = true, desc = "Search word under cursor" })
map("n", "<leader>fb", function() builtin("buffers") end, { silent = true, desc = "Find open buffers" })
map("n", "<leader>fh", function() builtin("help_tags") end, { silent = true, desc = "Search Neovim help" })
map("n", "<leader>fo", function() builtin("oldfiles") end, { silent = true, desc = "Recent files" })
map("n", "<leader>fs", function() builtin("lsp_document_symbols") end, { silent = true, desc = "Document symbols" })
map("n", "<leader>fr", function() builtin("lsp_references") end, { silent = true, desc = "Find references" })
-- vim.api.nvim_set_keymap('n', '<leader>ff', '<Cmd>Telescope find_files<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fg', '<Cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fb', '<Cmd>Telescope buffers<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fh', '<Cmd>Telescope help_tags<CR>', { noremap = true, silent = true })


map("n", "<leader>fk", function() builtin("keymaps") end, { desc = "Search all keymaps", silent = true })
map("n", "<leader>f/", function() builtin("current_buffer_fuzzy_find") end, { desc = "Search current buffer", silent = true })

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
vim.keymap.set("n", "<leader>fd", M.diff_buffers, { silent = true, desc = "Compare two buffers" })

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

function M.references()
  builtin("lsp_references")
end

return M
