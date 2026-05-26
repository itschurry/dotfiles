require("flutter-tools").setup({
  ui = {
    border = "rounded",
    notification_style = "native",
  },
  decorations = {
    statusline = {
      app_version = true,
      device = true,
      project_config = true,
    },
  },
  debugger = {
    enabled = false,
  },
  root_patterns = { ".git", "pubspec.yaml" },
  widget_guides = {
    enabled = true,
  },
  closing_tags = {
    enabled = true,
    highlight = "Comment",
    prefix = "> ",
  },
  dev_log = {
    enabled = true,
    open_cmd = "15split",
    focus_on_open = false,
  },
  dev_tools = {
    autostart = false,
    auto_open_browser = false,
  },
  outline = {
    open_cmd = "30vnew",
    auto_open = false,
  },
  lsp = {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      renameFilesWithClasses = "prompt",
      enableSnippets = true,
      updateImportsOnRename = true,
    },
  },
})

local map = vim.keymap.set

map("n", "<leader>Fl", "<cmd>FlutterLogToggle<CR>", { silent = true, desc = "Flutter log toggle" })
map("n", "<leader>Fo", "<cmd>FlutterOutlineToggle<CR>", { silent = true, desc = "Flutter outline toggle" })
map("n", "<leader>Fp", "<cmd>FlutterPubGet<CR>", { silent = true, desc = "Flutter pub get" })
map("n", "<leader>Fq", "<cmd>FlutterQuit<CR>", { silent = true, desc = "Flutter quit" })
map("n", "<leader>Fr", "<cmd>FlutterRun<CR>", { silent = true, desc = "Flutter run" })
map("n", "<leader>FR", "<cmd>FlutterReload<CR>", { silent = true, desc = "Flutter hot reload" })
map("n", "<leader>FS", "<cmd>FlutterRestart<CR>", { silent = true, desc = "Flutter hot restart" })
map("n", "<leader>Fd", "<cmd>FlutterDevices<CR>", { silent = true, desc = "Flutter devices" })
map("n", "<leader>Fe", "<cmd>FlutterEmulators<CR>", { silent = true, desc = "Flutter emulators" })
