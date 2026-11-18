return {
	setup = function()
		vim.pack.add { { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } }
		require("catppuccin").setup({
			custom_highlights = function(C)
				return {
					NeoTreeRootName = { fg = C.text },
					NeoTreeDirectoryName = { fg = C.text },
					NeoTreeDirectoryIcon = { fg = C.mauve },
				}
			end,
			integrations = {
				lualine = {
					all = function(C)
						return {
							normal = {
									a = { bg = C.mauve, gui = "bold" },
									b = { fg = C.mauve },
							},
							command = {
								a = { bg = C.maroon, fg = C.base, gui = "bold" },
								b = { bg = C.surface0, fg = C.maroon },
							},
							visual = {
								a = { bg = C.yellow, fg = C.base, gui = "bold" },
								b = { bg = C.surface0, fg = C.yellow },
							},
							replace = {
								a = { bg = C.peach, fg = C.base, gui = "bold" },
								b = { bg = C.surface0, fg = C.peach },
							},
							inactive = {
								a = { fg = C.mauve }
							}
						}
				end,
				}
			}
		})
	end
}
