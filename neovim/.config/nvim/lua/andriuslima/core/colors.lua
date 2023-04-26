local github_theme_status_ok, github_theme = pcall(require, "github-theme") -- Protective call to load theme

if not github_theme_status_ok then
    print("Could not load github-theme")
    return
end

vim.cmd "colorscheme moonfly"
vim.cmd "set colorcolumn=120"
