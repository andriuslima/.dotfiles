local status_ok, lf = pcall(require("lf"))
if not status_ok then
	return
end

lf.setup({
	escape_quit = false,
	border = "rounded",
})
