return {
	configure = function ()		
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"html",
				"css",
				"scss",
				"javascript",
				"typescript",
				"typescriptreact", -- .tsx
				"javascriptreact", -- .jsx
				"json",
				"lua",
				"vim",
				"bash"
			},
			callback = function()
				vim.treesitter.start()
			end
		})
	end
}
