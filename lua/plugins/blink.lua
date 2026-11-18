return {
	setup = function ()
		vim.pack.add({{
			src = "https://github.com/saghen/blink.cmp",
			version = vim.version.range("v1.*")
		}})
		require("blink.cmp").setup({
			keymap = { preset = "enter" }
		})
	end
}
