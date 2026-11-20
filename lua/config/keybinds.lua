return {
	configure = function ()
		vim.keymap.set("i", "<C-BS>", "<C-w>")

		vim.keymap.set("n", "<A-e>", function ()
			require("trouble").toggle("diagnostics")
		end)

		-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
		vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
		vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

		vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc <CR>')
		-- Normal mode: Code action
		vim.keymap.set("n", "<A-CR>", "<cmd>Lspsaga code_action<CR>", { desc = "Lspsaga code action" })

		-- Visual mode: Range code action (optional)
		vim.keymap.set("v", "<A-CR>", "<cmd>Lspsaga range_code_action<CR>", { desc = "Lspsaga range code action" })

		vim.keymap.set("n", "<A-d>", "<Cmd> Lspsaga term_toggle<CR>")
		vim.keymap.set("n", "<F18>", "<Cmd> Lspsaga rename<CR>")
		vim.keymap.set("n", "<A-u>", "<Cmd> Lspsaga finder<CR>")

		vim.keymap.set("n", "<A-1>", "<Cmd> Neotree toggle<CR>")

		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
		vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope old files" })
	end
}
