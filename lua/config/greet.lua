local dashboard = require("alpha.themes.dashboard")

local if_nil = vim.F.if_nil
local leader = "SPC"

local heading_images = {
	"leoni_1.png",
	"leoni_2.png",
	"leoni_3.png",
	"leoni_4.png",
	"leoni_5.png",
}

local leoneed_members = {
	{
		name = "Hoshino Ichika",
		icon = "🎸",
	},
	{
		name = "Tenma Saki",
		icon = "🎹",
	},
	{
		name = "Mochizuki Honami",
		icon = "🥁",
	},
	{
		name = "Hinomori Shiho",
		icon = "🍜",
	},
}

-- TODO: Find more iconic quotes from leoni
local leoneed_quotes = {
	{
		msg = "I'm just happy that I get to be up here with you now.",
		author = 1,
	},
	{
		msg = "Yeah! Let's make our dreams come true, as Leo/need!",
		author = 2,
	},
	{
		msg = "I'm just so happy that I'll be in a band with you.",
		author = 3,
	},
	{
		msg = "I believe we can do anything as long as we're together.",
		author = 4,
	},
	{
		msg = "I... I want us to stay true to our feelings. No matter what.",
		author = 3,
	},
	{
		msg = "I wanna move people's hearts while holding onto what I care about most...",
		author = 4,
	},
	{
		msg = "I want us to perform at our best... So I need to learn to carry us forward!",
		author = 3,
	},
}

local random = math.floor(math.random() * #leoneed_quotes) + 1
local quote = leoneed_quotes[random]
local author = leoneed_members[quote.author]

-- TODO: Adapt this to return a random quote
local dashboard_image_path = vim.fn.stdpath("config")
	.. "/assets/"
	.. heading_images[math.floor(math.random() * #heading_images) + 1]

local function button(sc, txt, keybind, keybind_opts)
	local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

	local opts = {
		position = "center",
		shortcut = sc,
		cursor = 3,
		width = 50,
		align_shortcut = "right",
		hl_shortcut = "Keyword",
	}
	if keybind then
		keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
		opts.keymap = { "n", sc_, keybind, keybind_opts }
	end

	local function on_press()
		pcall(function()
			require("image").clear()
		end)
		vim.cmd("redraw!")

		local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
		vim.api.nvim_feedkeys(key, "t", false)
	end

	return {
		type = "button",
		val = txt,
		on_press = on_press,
		opts = opts,
	}
end

local quoteBlock = {
	type = "group",
	val = {
		{
			type = "text",
			val = '"' .. quote.msg .. '"',
			opts = { hl = "comment", position = "center" },
		},
		{
			type = "text",
			val = " — " .. author.name .. " " .. author.icon .. " 💫",
			opts = { hl = "comment", position = "center" },
		},
	},
	opts = { spacing = 0 },
}

dashboard.section.buttons.val = {
	button("e", "  New file", "<cmd>ene <CR>"),
	button("SPC f f", "󰈞  Find file"),
	button("SPC f o", "󰊄  Recently opened files"),
	button("SPC f g", "󰈬  Find word"),
	-- dashboard.button("SPC f m", "  Jump to bookmarks"),
	-- dashboard.button("SPC s l", "  Open last session"),
}

-- Adapted from https://github.com/goolord/alpha-nvim/issues/15#issuecomment-4814163479
dashboard.config.opts = {
	setup = function()
		local image = nil
		local alpha_image_group = vim.api.nvim_create_augroup("AlphaImageRender", { clear = true })

		local alpha_buf = vim.api.nvim_get_current_buf()
		local win = vim.api.nvim_get_current_win()

		local image_width = 47
		local row = 1

		local function render_dashboard_image()
			if vim.api.nvim_get_current_buf() ~= alpha_buf then
				return
			end

			vim.schedule(function()
				if vim.api.nvim_get_current_buf() ~= alpha_buf or not vim.api.nvim_win_is_valid(win) then
					return
				end

				local win_width = vim.api.nvim_win_get_width(win)
				local col = math.floor((win_width - image_width) / 2)
				if col < 0 then
					col = 0
				end

				local has_tabline = #vim.api.nvim_list_tabpages() > 1
				if not has_tabline then
					row = 0
				end

				if image then
					pcall(function()
						image:clear()
					end)
				end

				image = require("image").from_file(dashboard_image_path, {
					window = nil,
					buffer = alpha_buf,
					width = image_width,
					x = col,
					y = row,
					with_virtual_padding = false,
					clear_in_background = true,
				})

				if image then
					pcall(function()
						image:render()
					end)
				end
			end)
		end

		vim.api.nvim_create_autocmd("User", {
			pattern = "AlphaReady",
			group = alpha_image_group,
			callback = function()
				render_dashboard_image()
			end,
		})

		vim.api.nvim_create_autocmd({ "BufEnter", "WinResized", "TextChanged", "VimResized" }, {
			buffer = alpha_buf,
			group = alpha_image_group,
			callback = function()
				vim.opt.showtabline = 1
				if vim.api.nvim_get_current_buf() ~= alpha_buf then
					return
				end
				vim.cmd("redraw")
				render_dashboard_image()
			end,
		})

		vim.api.nvim_create_autocmd({ "BufLeave", "BufUnload", "BufHidden" }, {
			buffer = alpha_buf,
			callback = function()
				vim.go.laststatus = 3
				vim.opt.showtabline = 2

				pcall(function()
					vim.api.nvim_del_augroup_by_id(alpha_image_group)
				end)

				pcall(function()
					require("image").clear()
				end)
				image = nil

				vim.cmd("redraw!")
			end,
		})
	end,
}

dashboard.config.layout = {
	{ type = "padding", val = 16 },
	quoteBlock,
	{ type = "padding", val = 1 },
	dashboard.section.buttons,
}

return dashboard.config
