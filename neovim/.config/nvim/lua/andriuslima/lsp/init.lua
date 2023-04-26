print("Loading lsp settings")

local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	print("Could not load lspconfig")
	return
end

require("andriuslima.lsp.configs")
require("andriuslima.lsp.handlers").setup()
require("andriuslima.lsp.null-ls")
