return {
	setup = function ()				
		vim.pack.add({
			{ src = "https://github.com/kevinhwang91/nvim-ufo"},
			"https://github.com/kevinhwang91/promise-async"
		})
		require('ufo').setup({
			close_fold_kinds_for_ft = {
				default = { "imports" }
			},
			provider_selector = function(bufnr, filetype, buftype)
				return {'lsp', 'indent'}
			end
		})
	end
}
