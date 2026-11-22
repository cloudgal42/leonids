return {
	setup = function ()
		vim.pack.add{
			{ src = 'https://github.com/neovim/nvim-lspconfig' },
		}

		vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter" } })

		vim.pack.add({{
			src = "https://github.com/lewis6991/gitsigns.nvim",
			name = "gitsigns"
		}})

		vim.pack.add({
			{ src = "https://github.com/nvim-telescope/telescope.nvim", name = "telescope" },
			"nvim-lua/plenary.nvim",
		})

		vim.pack.add({{
			src = "https://github.com/m4xshen/autoclose.nvim",
			name = "autoclose"
		}})
		require("autoclose").setup()

		vim.pack.add({{ src = "https://github.com/windwp/nvim-ts-autotag" }})
		require('nvim-ts-autotag').setup()

		vim.pack.add({{ src = "https://github.com/mason-org/mason.nvim" }})
		require("mason").setup()

		vim.pack.add({{ src = "https://github.com/nvimdev/lspsaga.nvim" }})
		require("lspsaga").setup()

		vim.pack.add({{ src = "https://github.com/3rd/image.nvim" }})
		require("image").setup()

		vim.pack.add({{ src = "https://github.com/folke/todo-comments.nvim" }})
		require("todo-comments").setup()

		vim.pack.add({{ src = "https://github.com/folke/trouble.nvim" }})
		require("trouble").setup()

		end
}
