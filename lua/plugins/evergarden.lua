return {
	setup = function ()		
		vim.pack.add({{ 
			src = "https://codeberg.org/evergarden/nvim.git", 
			name = "evergarden" 
		}})

		require('evergarden').setup({
			theme = {
				variant = 'winter', -- 'winter'|'fall'|'spring'|'summer'
				accent = 'green',
			},
			editor = {
				transparent_background = false,
				sign = { color = 'none' },
				float = {
					color = 'mantle',
					solid_border = false,
				},
				completion = {
					color = 'surface0',
				},
			},
		})
	end
}
