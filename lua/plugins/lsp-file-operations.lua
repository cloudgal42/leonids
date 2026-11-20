return {
	setup = function ()
		vim.pack.add({
			{ src = "https://github.com/antosha417/nvim-lsp-file-operations" },

			-- Uncomment whichever supported plugin(s) you use
			-- { src = "https://github.com/nvim-tree/nvim-tree.lua" },
			{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
			-- { src = "https://github.com/simonmclean/triptych.nvim" },
		})

		-- TODO: Find ways to fix auto_save = true causing original file to never be deleted and the moved file to contain incorrect imports
		require("lsp-file-operations").setup({ auto_save = false })
	end
}
