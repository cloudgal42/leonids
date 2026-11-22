return {
	setup = function()
		vim.pack.add({
			{
				src = "https://codeberg.org/maivi/nivvie.nvim",
				version = "7ac7630e7d2079a39d91d347eeece98993deb776",
			},
		})
		require("nivvie").setup({
			-- save on exit
			autosave = true,
			-- load on start
			autorestore = false,
		})
	end,
}
