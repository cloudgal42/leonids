return {
	setup = function ()		
		vim.pack.add({"https://github.com/lukas-reineke/indent-blankline.nvim"})
		local hooks = require("ibl.hooks")
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function ()
			vim.api.nvim_set_hl(0, "CurrentScope", { fg = "#C678DD" })
		end)

		require("ibl").setup({
			indent = { char = "│" },
			-- TODO: Fix this
			scope = {
				enabled = true,
				show_start = true,
				show_end = true,
				char = "┃",
				highlight = "CurrentScope"
			}
		})
	end
}
