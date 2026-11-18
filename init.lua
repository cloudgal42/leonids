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

require("plugins.misc").setup()

vim.keymap.set("n", "<A-e>", "<Cmd>lua vim.diagnostic.setqflist()<CR>")


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


vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- use Neovim nightly branch
vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:'

require("plugins.ufo").setup()

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

vim.opt.clipboard = "unnamedplus"
vim.keymap.set("i", "<C-BS>", "<C-w>")

vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc <CR>')
-- Normal mode: Code action
vim.keymap.set("n", "<A-CR>", "<cmd>Lspsaga code_action<CR>", { desc = "Lspsaga code action" })

-- Visual mode: Range code action (optional)
vim.keymap.set("v", "<A-CR>", "<cmd>Lspsaga range_code_action<CR>", { desc = "Lspsaga range code action" })


vim.keymap.set("n", "<A-1>", "<Cmd> Neotree toggle<CR>")
vim.keymap.set("n", "<A-d>", "<Cmd> Lspsaga term_toggle<CR>")
vim.keymap.set("n", "<F18>", "<Cmd> Lspsaga rename<CR>")

require("plugins.blink").setup()

require("plugins.evergarden").setup()
require("plugins.catppuccin").setup()
require("plugins.neotree").setup()




vim.cmd.colorscheme('catppuccin')

require("plugins.miniicons").setup()
require("plugins.lualine").setup()

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

require("plugins.indent-blankline").setup()

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
