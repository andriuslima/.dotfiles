local ok_status, harpoon = pcall(require, "harpoon")
if not ok_status then
    print("Could not load Harpoon")
    return
end

harpoon.setup({
  global_settings = {
    -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
    save_on_toggle = false,

    -- saves the harpoon file upon every change. disabling is unrecommended.
    save_on_change = true,

    -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
    enter_on_sendcmd = false,

    -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
    tmux_autoclose_windows = false,

    -- filetypes that you want to prevent from adding to the harpoon list menu.
    excluded_filetypes = { "harpoon" },

    -- set marks specific to each git branch inside git repository
    mark_branch = false,
}
})

local telescope_ok_status, telescope = pcall(require, "telescope")
if not telescope_ok_status then
    print("Could not load Telescope to add harpoon extension")
    return
end
telescope.load_extension('harpoon')
