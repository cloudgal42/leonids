return {
	setup = function ()		
		vim.pack.add({
			'https://github.com/nvim-tree/nvim-web-devicons',
			'https://github.com/nvim-lualine/lualine.nvim'
		})

		require('lualine').setup {
			options = { theme = 'catppuccin-nvim' },
			tabline = {
				lualine_a = {
					{ "tabs",
						mode = 2,
						path = 0,
						component_separators = { left = '', right = '' },
						section_separators = { left = '', right = '' },	
						use_mode_colors = true,
						fmt = function(name, context)
						-- Show + if buffer is modified in tab
							local buflist = vim.fn.tabpagebuflist(context.tabnr)
							local winnr = vim.fn.tabpagewinnr(context.tabnr)
							local bufnr = buflist[winnr]
							local mod = vim.fn.getbufvar(bufnr, '&mod')

							return name .. (mod == 1 and ' +' or '')
						end,
						max_length = vim.o.columns - 1,
					}
				}
			},
			sections = {
				lualine_y = {}
			}
		}
	end
}
