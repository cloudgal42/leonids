return {
	configure = function ()		
		vim.opt.tabstop = 2
		vim.opt.shiftwidth = 2
		vim.opt.softtabstop = 2
		vim.opt.completeopt = 'menuone,noselect'

		vim.o.foldcolumn = '1' -- '0' is not bad
		vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true

		-- use Neovim nightly branch
		vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:'

		vim.opt.clipboard = "unnamedplus"

		vim.opt.signcolumn = "yes"

	end
}
