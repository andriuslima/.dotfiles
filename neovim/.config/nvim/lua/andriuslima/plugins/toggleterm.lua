local status_ok, toggleterm = pcall(require, "toggleterm" )
if not status_ok then
    return
end

toggleterm.setup({
    size = 20,
    open_mapping = [[<A-\>]],
    hide_numbers = true,
    direction = "float",
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})

local terminal = require("toggleterm.terminal").Terminal
local lazygit = terminal:new( { cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end
