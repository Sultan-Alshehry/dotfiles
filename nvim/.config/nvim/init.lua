vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.opt.scrolloff = 8
vim.o.swapfile = false
vim.o.lazyredraw = true
vim.g.mapleader = " "

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

vim.opt.spelllang = { "en_us" }

vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')
vim.keymap.set({'n', 'v', 'x'}, 'y', '"+y')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "<leader>dd", ':lua vim.lsp.buf.code_action()')


vim.pack.add({

	{ src = 'https://github.com/catppuccin/nvim' },
	{ src = 'https://github.com/stevearc/oil.nvim' },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
  	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
	-- Autocomplete
	{ src = 'https://github.com/hrsh7th/nvim-cmp' },
	{ src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
	{ src = 'https://github.com/hrsh7th/cmp-buffer' },
	{ src = 'https://github.com/hrsh7th/cmp-path' },
	{ src = 'https://github.com/L3MON4D3/LuaSnip' },

})
vim.cmd("packadd nvim-treesitter")
require("nvim-treesitter.config").setup({
  highlight = { enable = true },
})


require "oil".setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config("*", {
	capabilities = capabilities,
})
vim.lsp.enable({
	"lua_ls",
	"pylsp",
	"bashls",
	"clangd",
    "jdtls"
})

local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
	}),
})


vim.cmd.colorscheme("catppuccin")
