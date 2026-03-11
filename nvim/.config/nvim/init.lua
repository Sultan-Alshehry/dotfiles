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

vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set("n", "<leader>e", ":Oil<CR>")
vim.keymap.set({ "n", "v", "x" }, "y", '"+y')
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "<leader>dd", ":lua vim.lsp.buf.code_action()")

vim.pack.add({

    { src = "https://github.com/catppuccin/nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    -- Autocomplete
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/hrsh7th/cmp-buffer" },
    { src = "https://github.com/hrsh7th/cmp-path" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },

    { src = "https://github.com/windwp/nvim-autopairs" },
})

require('nvim-autopairs').setup()

require("oil").setup()

vim.cmd.colorscheme("catppuccin")

vim.cmd("packadd nvim-treesitter")
require("nvim-treesitter.config").setup({
    highlight = { enable = true },
})

vim.lsp.enable({
    "lua_ls",
    "pylsp",
    "bashls",
    "clangd",
    "jdtls",
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                end,
            })
        end
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {
        "c",
        "cpp",
        "css",
        "html",
        "javascript",
        "java",
        "json",
        "lua",
        "markdown",
        "python",
        "sh",
    },
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
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

vim.lsp.config("pylsp.setup", {
    settings = {
        pylsp = {
            plugins = {
                black = { enabled = true },
                flake8 = { enabled = true },
            }
        }
    }
})
