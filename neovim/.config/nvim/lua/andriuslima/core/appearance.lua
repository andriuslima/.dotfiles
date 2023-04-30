vim.cmd("set colorcolumn=120")

require("catppuccin").setup({
    flavour = "mocha",
    background = {
        light = "macchiato",
        dark = "mocha",
    },
    transparent_background = true,
    show_end_of_buffer = false, -- do not show the '~' characters after the end of buffers
    term_colors = true,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        harpoon = true,
        telescope = true,
        alpha = true,
        nvimtree = true,
        treesitter = true,
    },
})

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")
