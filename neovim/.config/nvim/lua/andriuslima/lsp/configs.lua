local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local lspconfig = require("lspconfig")

local servers = {
  "awk_ls",
  "omnisharp",
  "clangd",
  "cssls",
  "dockerls",
  "eslint",
  "gopls",
  "grammarly",
  "groovyls",
  "html",
  "jsonls",
  "jdtls",
  "tsserver",
  "kotlin_language_server",
  "sumneko_lua",
  "prismals",
  "pyright",
  "terraformls",
  "lemminx",
  "yamlls",
}

lsp_installer.setup {
  ensure_installed = servers
}

for _, server in pairs(servers) do
  local opts = {
    on_attach = require("andriuslima.lsp.handlers").on_attach,
    capabilities = require("andriuslima.lsp.handlers").capabilities,
  }
  local has_custom_opts, server_custom_opts = pcall(require, "andriuslima.lsp.settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end
  lspconfig[server].setup(opts)
end
