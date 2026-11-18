return {
	setup = function ()
		vim.pack.add({{ src = "https://github.com/goolord/alpha-nvim" }})
		require("alpha").setup(require("config.greet"))
	end
}
