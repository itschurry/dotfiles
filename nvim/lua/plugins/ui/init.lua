local M = {}

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
    view = {
      width = 60,
      side = "right",
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
    filters = {
      dotfiles = true,
    },
    renderer = {
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
      },
    },
  }
end)

vim.keymap.set("n", "<leader>n", function()
  M.nvim_tree()
  vim.cmd("NvimTreeToggle")
end, { silent = true })

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
    section_separators = { "", "" },
    component_separators = { "", "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {
      {
        "filename",
        path = 2,
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
    numbers = "ordinal",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
      local icon = tostring(level):match("error") and "" or ""
      return " " .. icon .. " " .. count
    end,
    close_command = "bdelete %d",
    right_mouse_command = "bdelete %d",
    middle_mouse_command = "bdelete %d",
    show_buffer_close_icons = false,
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
      show_start = true,
      show_end = true,
    },
    exclude = {
      filetypes = { "help", "dashboard", "terminal" },
    },
  }
end)

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  once = true,
  callback = M.indent,
})

vim.cmd("packadd gitsigns.nvim")
require("gitsigns").setup {
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  current_line_blame = true,
}

vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "DiffAdd" })
vim.api.nvim_set_hl(0, "GitSignsChange", { link = "DiffChange" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "DiffDelete" })
vim.api.nvim_set_hl(0, "GitSignsTopdelete", { link = "DiffDelete" })
vim.api.nvim_set_hl(0, "GitSignsChangedelete", { link = "DiffChange" })

local function setup_comment()
  vim.cmd("packadd Comment.nvim")
  require("Comment").setup({
    mappings = {
      basic = false,
      extra = false,
    },
  })
end

local comment = once(setup_comment)

vim.keymap.set("n", "<leader>/", function()
  comment()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle line comment" })

vim.keymap.set("v", "<leader>/", function()
  comment()
  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(esc, "x", false)
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Visual toggle line comment" })

vim.keymap.set("n", "<M-/>", function()
  comment()
  require("Comment.api").toggle.blockwise.current()
end, { desc = "Toggle block comment" })

vim.keymap.set("v", "<M-/>", function()
  comment()
  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(esc, "x", false)
  require("Comment.api").toggle.blockwise(vim.fn.visualmode())
end, { desc = "Visual toggle block comment" })

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
  })

  local bg = vim.api.nvim_get_hl_by_name("Normal", true).background
  local notify = require("notify")

  notify.setup({
    background_colour = string.format("#%06x", bg or 0x000000),
    timeout = 3000,
    render = "compact",
    stages = "fade_in_slide_out",
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

return M
