vim.opt.background = "light"
vim.cmd("source ~/.vimrc")

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.completeopt = 'menuone,noselect'

vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	severity_sort = true,
	update_in_insert = true,
})

vim.keymap.set("n", "<A-e>", "<Cmd>lua vim.diagnostic.setqflist()<CR>")

vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' },
}

vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter" } })

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"html",
    "css",
    "scss",
    "javascript",
    "typescript",
    "typescriptreact", -- .tsx
    "javascriptreact", -- .jsx
    "json",
		"lua",
		"vim",
		"bash"
	},
	callback = function()
		vim.treesitter.start()
	end
})

vim.pack.add({
	{ src = "https://github.com/kevinhwang91/nvim-ufo"},
	"https://github.com/kevinhwang91/promise-async"
})

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- use Neovim nightly branch
vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:'

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

require('ufo').setup({
	close_fold_kinds_for_ft = {
		default = { "imports" }
	},
  provider_selector = function(bufnr, filetype, buftype)
    return {'lsp', 'indent'}
  end
})

vim.opt.clipboard = "unnamedplus"
vim.keymap.set("i", "<C-BS>", "<C-w>")

vim.pack.add({ { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("v1.*") } })
require("blink.cmp").setup({
	keymap = { preset = "super-tab" }
})
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc <CR>')
-- Normal mode: Code action
vim.keymap.set("n", "<A-CR>", "<cmd>Lspsaga code_action<CR>", { desc = "Lspsaga code action" })

-- Visual mode: Range code action (optional)
vim.keymap.set("v", "<A-CR>", "<cmd>Lspsaga range_code_action<CR>", { desc = "Lspsaga range code action" })

vim.pack.add({ { src = "https://codeberg.org/evergarden/nvim.git", name = "evergarden" } })

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

vim.pack.add({
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range('3')
  },
  -- dependencies
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  -- optional, but recommended
  "https://github.com/nvim-tree/nvim-web-devicons",
})
require("neo-tree").setup({
	window = {
		width = 25
	}
})
vim.keymap.set("n", "<A-1>", "<Cmd> Neotree toggle<CR>")
vim.keymap.set("n", "<A-d>", "<Cmd> Lspsaga term_toggle<CR>")
vim.keymap.set("n", "<F18>", "<Cmd> Lspsaga rename<CR>")

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

require('evergarden').setup({
  theme = {
    variant = 'summer', -- 'winter'|'fall'|'spring'|'summer'
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

vim.cmd.colorscheme('catppuccin')

vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })
local MiniIcons = require("mini.icons")
MiniIcons.setup()
MiniIcons.mock_nvim_web_devicons()

vim.pack.add({{ src = "https://github.com/lewis6991/gitsigns.nvim", name = "gitsigns" }})

vim.pack.add({
	{ src = "https://github.com/nvim-telescope/telescope.nvim", name = "telescope" },
	"nvim-lua/plenary.nvim",
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.pack.add({"https://github.com/lukas-reineke/indent-blankline.nvim"})
local hooks = require("ibl.hooks")
hooks.register(hooks.type.HIGHLIGHT_SETUP, function ()
	vim.api.nvim_set_hl(0, "CurrentScope", { fg = "#C678DD" })
end)

require("ibl").setup({
	indent = { char = "│" },
	-- TODO: Fix this
	scope = {
		enabled = true,
		show_start = true,
		show_end = true,
		char = "┃",
		highlight = "CurrentScope"
	}
})

vim.pack.add({{ src = "https://github.com/m4xshen/autoclose.nvim", name = "autoclose" }})
require("autoclose").setup()

vim.pack.add({{ src = "https://github.com/windwp/nvim-ts-autotag" }})
require('nvim-ts-autotag').setup()

vim.pack.add({{ src = "https://github.com/mason-org/mason.nvim" }})
require("mason").setup()

vim.pack.add({{ src = "https://github.com/nvimdev/lspsaga.nvim" }})
require("lspsaga").setup()

vim.opt.signcolumn = "yes"
vim.api.nvim_set_hl(0, "@variable", { link = "@variable" })

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }
			}
		}
	}
})

-- TODO: See why this is throwing an error
-- vim.pack.add({ "https://codeberg.org/maivi/nivvie.nvim" })

-- Set default root markers for all clients
-- vim.lsp.config('*', {
--   root_markers = { '.git' },
-- })

-- Set configuration for typescript language server
-- vim.lsp.config('ts_ls', {
--   root_markers = { 'package.json' },
--	 cmd = { 'typescript-language-server', '--stdio' },
--   filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
-- 	 workspace_required = false,
-- })

local util = require 'lspconfig.util'

local eslint_config_files = {
  '.eslintrc',
  '.eslintrc.js',
  '.eslintrc.cjs',
  '.eslintrc.yaml',
  '.eslintrc.yml',
  '.eslintrc.json',
  'eslint.config.js',
  'eslint.config.mjs',
  'eslint.config.cjs',
  'eslint.config.ts',
  'eslint.config.mts',
  'eslint.config.cts',
}

-- Specify custom root_dir function to not ignore deno (like Webstorm)
vim.lsp.config("eslint", {
	root_dir = function(bufnr, on_dir)
    -- The project root is where the LSP can be started from
    -- As stated in the documentation above, this LSP supports monorepos and simple projects.
    -- We select then from the project root, which is identified by the presence of a package
    -- manager lock file.
    local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }
    -- Give the root markers equal priority by wrapping them in a table
    root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers, { '.git' } }
      or vim.list_extend(root_markers, { '.git' })

    -- Do not exclude deno
    -- if vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc', 'deno.lock' }) then
    --   return
    -- end

    -- We fallback to the current working directory if no project root is found
    local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

    -- We know that the buffer is using ESLint if it has a config file
    -- in its directory tree.
    --
    -- Eslint used to support package.json files as config files, but it doesn't anymore.
    -- We keep this for backward compatibility.
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local eslint_config_files_with_package_json =
      util.insert_package_json(eslint_config_files, 'eslintConfig', filename)
    local is_buffer_using_eslint = vim.fs.find(eslint_config_files_with_package_json, {
      path = filename,
      type = 'file',
      limit = 1,
      upward = true,
      stop = vim.fs.dirname(project_root),
    })[1]
    if not is_buffer_using_eslint then
      return
    end

    on_dir(project_root)
  end,
})

-- Enable Typescript Language Server
vim.lsp.enable('ts_ls')
vim.lsp.enable('denols')
vim.lsp.enable('eslint')
vim.lsp.enable('cssls')
vim.lsp.enable('lua_ls')
