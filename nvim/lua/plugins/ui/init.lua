local M = {}

vim.cmd("packadd which-key.nvim")
require("which-key").setup {
  preset = "classic",
  delay = 300,
}
require("which-key").add {
  { "<leader>b", group = "Buffers" },
  { "<leader>c", group = "Code / Build" },
  { "<leader>f", group = "Find" },
  { "<leader>r", group = "REST / Rsync" },
}

local function once(fn)
  local loaded = false
  return function()
    if loaded then
      return
    end
    loaded = true
    fn()
  end
end

M.nvim_tree = once(function()
  vim.cmd("packadd nvim-tree.lua")
  require("nvim-tree").setup {
    hijack_cursor = true,
    update_focused_file = { enable = true },
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")
      api.config.mappings.default_on_attach(bufnr)
      -- 루트 이동은 좌우 방향키처럼 h/l로 통일하고 이름 변경은 e 유지
      vim.keymap.del("n", "-", { buffer = bufnr })
      vim.keymap.del("n", "<C-]>", { buffer = bufnr })
      vim.keymap.del("n", "r", { buffer = bufnr })
      vim.keymap.set("n", "h", api.tree.change_root_to_parent, { buffer = bufnr, desc = "Root: Parent directory", silent = true, nowait = true })
      vim.keymap.set("n", "l", api.tree.change_root_to_node, { buffer = bufnr, desc = "Root: Selected directory", silent = true, nowait = true })
      vim.keymap.set("n", "?", api.tree.toggle_help, { buffer = bufnr, desc = "Tree key help", silent = true, nowait = true })
      vim.keymap.set("n", "mc", api.marks.clear, { buffer = bufnr, desc = "Clear marked files", silent = true })
    end,
    view = {
      width = 40,
      side = "right",
    },
    actions = {
      open_file = {
        quit_on_open = false,
      },
    },
    filters = {
      dotfiles = false,
      custom = { "^\\.git$" },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = false,
      severity = { min = vim.diagnostic.severity.WARN },
    },
    modified = { enable = true },
    tab = { sync = { open = true, close = true } },
    renderer = {
      group_empty = true,
      highlight_opened_files = "name",
      indent_markers = { enable = true },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
          modified = true,
          diagnostics = true,
        },
      },
    },
  }
end)

vim.keymap.set("n", "<leader>n", function()
  M.nvim_tree()
  vim.cmd("NvimTreeToggle")
end, { silent = true, desc = "Toggle file explorer" })

M.aerial = once(function()
  vim.cmd("packadd aerial.nvim")
  require("aerial").setup {
    backends = { "lsp", "treesitter", "markdown" },
    layout = {
      default_direction = "float",
      width = 80,
    },
    show_guides = true,
    filter_kind = {
      "Class",
      "Function",
      "Method",
      "Variable",
    },
  }
end)

vim.keymap.set("n", "<leader>t", function()
  M.aerial()
  vim.cmd("AerialToggle")
end, { silent = true })

vim.cmd("packadd lualine.nvim")
require("lualine").setup {
  options = {
    theme = "auto",
    globalstatus = true,
    section_separators = "",
    component_separators = "",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {
      {
        "filename",
        path = 1,
      },
    },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
}

vim.cmd("packadd bufferline.nvim")
require("bufferline").setup {
  options = {
    mode = "buffers",
    numbers = "none",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
      local icon = tostring(level):match("error") and "" or ""
      return " " .. icon .. " " .. count
    end,
    close_command = "confirm bdelete %d",
    right_mouse_command = "confirm bdelete %d",
    middle_mouse_command = "confirm bdelete %d",
    show_buffer_close_icons = true,
    show_close_icon = false,
    always_show_bufferline = false,
    separator_style = "thin",
    sort_by = "insert_after_current",
    indicator = {
      style = "icon",
      icon = "▎",
    },
    hover = {
      enabled = true,
      delay = 200,
      reveal = { "close" },
    },
    offsets = {
      {
        filetype = "NvimTree",
        text = "Files",
        text_align = "center",
        separator = true,
      },
    },
  },
}

M.indent = once(function()
  vim.cmd("packadd indent-blankline.nvim")
  require("ibl").setup {
    indent = {
      char = "│",
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
    },
    exclude = {
      filetypes = { "help", "alpha", "dashboard", "terminal", "NvimTree", "aerial", "TelescopePrompt", "noice", "notify" },
    },
  }
end)

-- 첫 파일은 BufReadPost 이후에 UI가 로드되므로 즉시 적용
M.indent()

vim.cmd("packadd gitsigns.nvim")
require("gitsigns").setup {
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  current_line_blame = false,
}
vim.keymap.set("n", "<leader>gp", function()
  require("gitsigns").preview_hunk()
end, { silent = true, desc = "Preview Git changes" })

M.ui_effects = once(function()
  vim.cmd("packadd nui.nvim")
  vim.cmd("packadd noice.nvim")
  vim.cmd("packadd nvim-notify")

  require("noice").setup({
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
    },
    messages = {
      enabled = true,
      view = "mini",
    },
    popupmenu = {
      enabled = true,
    },
    lsp = {
      signature = {
        enabled = false,
      },
    },
    presets = { lsp_doc_border = true },
  })

  local bg = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg
  local notify = require("notify")

  notify.setup({
    background_colour = string.format("#%06x", bg),
    timeout = 3000,
    render = "compact",
    stages = "static",
    top_down = false,
  })
  vim.notify = notify
end)

M.ui_effects()

vim.api.nvim_create_user_command("UiEffectsEnable", function()
  M.ui_effects()
end, { desc = "Enable noice.nvim and nvim-notify" })

vim.cmd("packadd twilight.nvim")
vim.cmd("packadd zen-mode.nvim")
require("twilight").setup()
require("zen-mode").setup {
  window = {
    width = 80,
    options = {
      number = false,
      relativenumber = false,
    },
  },
}

vim.keymap.set("n", "<leader>fn", function()
  M.nvim_tree()
  require("nvim-tree.api").tree.find_file({ open = true, focus = true })
end, { desc = "Reveal current file in explorer", silent = true })

return M
