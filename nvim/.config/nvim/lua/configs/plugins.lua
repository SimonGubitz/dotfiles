-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
	if vim.v.shell_error ~= 0 then
		error('Error cloning lazy.nvim:\n' .. out)
	end
end


---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)


require('lazy').setup({
	'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically
	{ 'nvim-treesitter/nvim-treesitter-context', },
	{ 'lewis6991/gitsigns.nvim',                 config = function() require 'plugins.gitsigns' end, },

	{
		'akinsho/toggleterm.nvim',
		version = '*',
		config = function()
			require 'plugins.nvim-toggleterm'
		end,
	},

	{
		'folke/which-key.nvim',
		event = 'VimEnter',
		config = function()
			require 'plugins.which-key'
		end,
	},

	{
		'folke/persistence.nvim',
		event = 'BufReadPre',
		opts = {
			options = { 'folds' },
		},
	},

	{
		'nvim-telescope/telescope.nvim',
		event = 'VimEnter',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
			{ 'nvim-telescope/telescope-ui-select.nvim' },
			{ 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
		},
		config = function()
			require 'plugins.nvim-telescope'
		end,
	},

	{
		'folke/lazydev.nvim',
		ft = 'lua',
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
			},
		},
	},
	{
		-- Main LSP Configuration
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'mason-org/mason.nvim', opts = {} },
			'mason-org/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',

			-- Allows extra capabilities provided by blink.cmp
			'saghen/blink.cmp',
		},
		config = function()
			require 'plugins.lsp'
		end,
	},

	{ -- Autoformat
		'stevearc/conform.nvim',
		event = { 'BufWritePre' },
		cmd = { 'ConformInfo' },
		keys = {
			{
				'<leader>f',
				function()
					require('conform').format { async = true, lsp_format = 'fallback' }
				end,
				mode = '',
				desc = '[F]ormat buffer',
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 500,
						lsp_format = 'fallback',
					}
				end
			end,
			formatters_by_ft = {
				lua = { 'stylua' },
				xml = { 'xmlformatter' },
				javascript = { 'prettierd', 'prettier', stop_after_first = true },
				json = { 'fixjson' },
			},
		},
	},

	{ -- Autocompletion
		'saghen/blink.cmp',
		event = 'VimEnter',
		version = '1.*',
		dependencies = {
			-- Snippet Engine
			{
				'L3MON4D3/LuaSnip',
				version = '2.*',
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
						return
					end
					return 'make install_jsregexp'
				end)(),
				dependencies = {},
				opts = {},
			},
			'folke/lazydev.nvim',
		},
		opts = {
			keymap = {
				-- 'default' (recommended) for mappings similar to built-in completions
				--   <c-y> to accept ([y]es) the completion.
				--    This will auto-import if your LSP supports it.
				--    This will expand snippets if the LSP sent a snippet.
				-- 'super-tab' for tab to accept
				-- 'enter' for enter to accept
				-- 'none' for no mappings
				--
				-- For an understanding of why the 'default' preset is recommended,
				-- you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				--
				-- All presets have the following mappings:
				-- <tab>/<s-tab>: move to right/left of your snippet expansion
				-- <c-space>: Open menu or open docs if already open
				-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
				-- <c-e>: Hide menu
				-- <c-k>: Toggle signature help
				--
				-- See :h blink-cmp-config-keymap for defining your own keymap
				preset = 'default',

				-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
				--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = 'mono',
			},

			completion = {
				-- By default, you may press `<c-space>` to show the documentation.
				-- Optionally, set `auto_show = true` to show the documentation after a delay.
				documentation = { auto_show = false, auto_show_delay_ms = 500 },
			},

			sources = {
				default = { 'lsp', 'path', 'snippets', 'lazydev' },
				providers = {
					lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
				},
			},

			snippets = { preset = 'luasnip' },

			-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
			-- which automatically downloads a prebuilt binary when enabled.
			--
			-- By default, we use the Lua implementation instead, but you may enable
			-- the rust implementation via `'prefer_rust_with_warning'`
			--
			-- See :h blink-cmp-config-fuzzy for more information
			fuzzy = { implementation = 'lua' },

			-- Shows a signature help window while you type arguments for a function
			signature = { enabled = true },
		},
	},

	-- ### Themes ###
	{ 'folke/tokyonight.nvim',    priority = 1000 },
	{ 'ThorstenRhau/token',       version = '*' },

	-- Highlight todo, notes, etc in comments
	{ 'folke/todo-comments.nvim', event = 'VimEnter',                             dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
	{ 'echasnovski/mini.nvim',    config = function() require 'plugins.mini' end, },

	{ -- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		branch = 'master',
		lazy = false,
		build = ':TSUpdate',
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
		--
		main = 'nvim-treesitter.configs',
		opts = {
			ensure_installed = { 'bash', 'c', 'cpp', 'diff', 'go', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'json' },
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		},
	},
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = '⌘',
			config = '🛠',
			event = '📅',
			ft = '📂',
			init = '⚙',
			keys = '🗝',
			plugin = '🔌',
			runtime = '💻',
			require = '🌙',
			source = '📄',
			start = '🚀',
			task = '📌',
			lazy = '💤 ',
		},
	},
})
