print("Loading plugins settings")

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	print("Could not load packer. Exiting...")

	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" }) -- Have packer use a popup window
		end,
	},
})

packer.startup(function(use)
	use("lewis6991/impatient.nvim")
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/plenary.nvim") -- All the lua functions I don't want to write twice.
	use("folke/which-key.nvim") --  Displays a popup with possible key bindings of the command you started typing.
	use("nvim-lualine/lualine.nvim") -- A blazing fast and easy to configure Neovim statusline written in Lua.
	use("akinsho/bufferline.nvim") -- A snazzy buffer line (with tabpage integration) for Neovim built using lua.
	use("akinsho/toggleterm.nvim")

	use("moll/vim-bbye") -- Bbye allows you to do delete buffers (close files) without closing your windows or messing up your layout.
	use("kyazdani42/nvim-web-devicons") -- Icons for nvim-tree
	use("kyazdani42/nvim-tree.lua") -- File explorer

	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- Syntax
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("JoosepAlviste/nvim-ts-context-commentstring") -- Enable context awareness comment
	use("nvim-telescope/telescope.nvim") -- Fuzzy finder
	use("lewis6991/gitsigns.nvim") -- Git editor decorations

	-- CMP Plugins (Complettion engine)
	use("hrsh7th/nvim-cmp") -- A completion engine plugin for neovim written in Lua.
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("hrsh7th/cmp-nvim-lsp") -- lsp completions

	-- Snippets
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("L3MON4D3/LuaSnip") --snippet engine

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("jose-elias-alvarez/null-ls.nvim")

	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use("ahmedkhalf/project.nvim") -- project manager
	use("goolord/alpha-nvim") -- Startup screen
	use("ThePrimeagen/harpoon")

	-- Themes
	use({ "bluz71/vim-moonfly-colors", as = "moonfly" })

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

require("andriuslima.plugins.treesitter") -- Nvim Treesitter configurations and abstraction layer
require("andriuslima.plugins.impatient") -- Spped up loeading Lua modules
require("andriuslima.plugins.telescope") -- Highly extendable fuzzy finder over lists.
require("andriuslima.plugins.lualine") -- Status line
require("andriuslima.plugins.bufferline") -- Buffer line
require("andriuslima.plugins.nvim-tree") -- File explorer
require("andriuslima.plugins.cmp") -- A completion engine plugin for neovim written in Lua.
require("andriuslima.plugins.autopairs") -- Auto close {} [] "" ''
require("andriuslima.plugins.comment") -- Better way to add comments
require("andriuslima.plugins.whichkey") -- keymaps pop-up
require("andriuslima.plugins.gitsigns") -- git editor decorations
require("andriuslima.plugins.project") -- Project manager
require("andriuslima.plugins.alpha") -- Startup screen
require("andriuslima.plugins.harpoon") -- Marks manager
require("andriuslima.plugins.toggleterm")
