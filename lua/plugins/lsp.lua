return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
	},
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		build = "make install_jsregexp",
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "onsails/lspkind.nvim" },
		},
		config = function()
			local cmp = require("cmp")

			local lspkind = require("lspkind")

			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "nvim_lsp" },
				}, {
					{ name = "buffer" },
				}),
				mapping = {
					-- `Enter` key to confirm completion
					["<CR>"] = cmp.mapping.confirm({ select = true }),

					-- Ctrl+Space to trigger completion menu
					["<C-Space>"] = cmp.mapping.complete(),

					["<C-e>"] = cmp.mapping.abort(),

					-- Navigate between snippet placeholder
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
				},
				formatting = {
					format = lspkind.cmp_format({
						maxwidth = 100, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					}),
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "folke/neodev.nvim" },
		},
		config = function()
			require("neodev").setup()

			local lsp = require("lspconfig")
			lsp.tsserver.setup({
				documentFormattingProvider = false,
			})
			lsp.groovyls.setup({
				cmd = {
					"java",
					"-jar",
					require("mason-registry").get_package("groovy-language-server"):get_install_path()
						.. "/build/libs/groovy-language-server-all.jar",
				},
			})
			lsp.rust_analyzer.setup({
				settings = {
					["rust-analyzer"] = {
						cargo = {
							extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = "dev" },
							extraArgs = { "--profile", "rust-analyzer" },
						},
					},
				},
			})
			lsp.eslint.setup({
				on_attach = function(_, _) vim.keymap.set("n", "<leader>f", "<cmd>EslintFixAll<cr>") end,
			})
			lsp.clangd.setup({
				cmd = { "clangd", "--clang-tidy", "--offset-encoding=utf-16" },
				on_attach = function(_, _) vim.keymap.set("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>") end,
				filetypes = { "c", "cpp" },
			})
			lsp.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
							disable = { "missing-fields" },
						},
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
					local client_id = ev.data.client_id
					local client = vim.lsp.get_client_by_id(client_id)

					if client == nil then return end

					-- esLint AutoFormatting
					-- vim.api.nvim_create_autocmd("BufWritePre", {
					--   pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
					--   command = "EslintFixAll",
					-- })

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }

					vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
					vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
					vim.keymap.set("n", "go", function() vim.lsp.buf.type_definition() end, opts)
					vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
					vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
					vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
					vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
					-- In favor of trouble references
					vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
					vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
					vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
					vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
					vim.keymap.set("i", "<C-r>", function() vim.lsp.buf.signature_help() end, opts)
					vim.keymap.set("n", "gs", function() vim.lsp.buf.signature_help() end, opts)
					vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
					vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)

					if client.server_capabilities.inlayHintProvider then
						vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
					end

					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = ev.buf,
						callback = function()
							if not client.supports_method("textDocument/formatting") then return end
							if client.name == "jdtls" or client.name == "tsserver" then return end
							vim.lsp.buf.format({
								async = false,
								filter = function(c) return c.id == client.id end,
							})
						end,
					})
				end,
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		event = "BufReadPre",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					--null_ls.builtins.formatting.prettierd,
					--null_ls.builtins.formatting.clang_format,
				},
			})
		end,
	},
	{ "mfussenegger/nvim-jdtls", event = "BufReadPre *.java" },
}
