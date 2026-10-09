vim.cmd("packadd mason.nvim")
vim.cmd("packadd mason-lspconfig.nvim")
vim.cmd("packadd nvim-lspconfig")

-- mason은 "설치"만 맡기고, 설정/활성화는 core API로
local mason = require("mason")
local mlsp  = require("mason-lspconfig")
mason.setup()
mlsp.setup { ensure_installed = { "pyright", "dockerls", "jsonls", "yamlls", "lua_ls", "bashls" } }

-- 코드 전체를 진단 문구로 채우지 않고 현재 줄의 오류/경고만 표시
vim.diagnostic.config({
  virtual_text = {
    current_line = true,
    severity = { min = vim.diagnostic.severity.WARN },
    spacing = 2,
    prefix = "●",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
  },
  underline = true,
  severity_sort = true,
  update_in_insert = false,
  float = { border = "rounded", source = "if_many", header = "", prefix = "" },
})

-- Flutter를 포함한 모든 LSP에 같은 키맵 적용
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("PersonalLsp", { clear = true }),
  callback = function(event)
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = event.buf, silent = true, desc = desc })
    end
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gD", vim.lsp.buf.declaration, "Go to declaration")
    map("gi", vim.lsp.buf.implementation, "Go to implementation")
    map("gy", vim.lsp.buf.type_definition, "Go to type definition")
    map("K", vim.lsp.buf.hover, "Show symbol documentation")
    map("gr", function() require("plugins.navigation.telescope").references() end, "Find references")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("<leader>cs", vim.lsp.buf.signature_help, "Show function signature")
    map("<F2>", vim.lsp.buf.rename, "Rename symbol")
    map("<F12>", vim.lsp.buf.definition, "Go to definition")
  end,
})

local capabilities = require("blink.cmp").get_lsp_capabilities()
capabilities.offsetEncoding = { "utf-16" }

-- ⬇️ 핵심: 새 API로 clangd 구성
vim.lsp.config('clangd', {
  cmd = {
    "clangd",
    "--background-index",
    "--header-insertion=never",
    "--completion-style=detailed",
    "--pch-storage=memory",
    "--j=6",
    "--log=error",
    "--limit-results=30",
  },
  capabilities = capabilities,
  root_markers = { "compile_commands.json", ".git" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
})

vim.lsp.config('pyright', {
  capabilities = capabilities,
})

vim.lsp.config('dockerls', {
  capabilities = capabilities,
})

vim.lsp.config('jsonls', {
  capabilities = capabilities,
})

vim.lsp.config('yamlls', {
  capabilities = capabilities,
})

vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
    },
  },
})

vim.lsp.config('bashls', {
  capabilities = capabilities,
})

vim.lsp.enable({ 'clangd', 'pyright', 'dockerls', 'jsonls', 'yamlls', 'lua_ls', 'bashls' })
