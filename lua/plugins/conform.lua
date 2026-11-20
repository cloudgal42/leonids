return {
	setup = function ()
		vim.pack.add({{ src = "https://github.com/stevearc/conform.nvim" }})
		require("conform").setup({
			formatters_by_ft = {
				javascript = { "prettier", "deno_fmt", "js_beautify", stop_after_first = true },
				typescript = { "prettier", "deno_fmt", "js_beautify", stop_after_first = true },
				javascriptreact = { "prettier", "deno_fmt", "js_beautify", stop_after_first = true },
				typescriptreact = { "prettier", "deno_fmt", "js_beautify", stop_after_first = true },
				html = { "prettier", "html_beautify", stop_after_first = true },
				lua = { "stylua" }
			}
		})
	end
}
