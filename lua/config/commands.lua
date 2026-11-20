return {
	configure = function ()
		vim.api.nvim_create_user_command("Todo", function (opts)
			if opts ~= nil then
				vim.cmd("TodoLocList")
			else
				vim.cmd({
					cmd = "TodoLocList",
					args = opts.args
			})
			end
		end, {})

		vim.api.nvim_create_user_command("Wrap", ":set wrap!", {})
	end
}
