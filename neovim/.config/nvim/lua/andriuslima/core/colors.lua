local github_theme_status_ok, github_theme = pcall(require, "github-theme") -- Protective call to load theme

if not github_theme_status_ok then
    print("Could not load github-theme")
    return
end

-- vim.opt.colorcolumn = { 120, 180 }

github_theme.setup({
    theme_style = "dark_default"
})
