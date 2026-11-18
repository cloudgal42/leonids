return {
	configure = function ()		
		vim.opt.background = "light"
		vim.cmd.colorscheme('catppuccin')
		vim.api.nvim_set_hl(0, "@variable", { link = "@variable" })
	end
}
