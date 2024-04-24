return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", requires = "nvim-lua/plenary.nvim" },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- installing manually because Mason didnt have vhdl_ls
		lspconfig.vhdl_ls.setup({
			-- Server-specific settings. See `:help lspconfig-setup`
			settings = {
				["vhdl_ls"] = {},
			},
		})

		-- installing manually because internal zls provided with Mason is outdated
		lspconfig.zls.setup({
			-- Server-specific settings. See `:help lspconfig-setup`
			settings = {
				["zls"] = {},
			},
		})

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>FzfLua lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>FzfLua lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "Code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts) -- smart rename

				--	opts.desc = "Buffer diagnostics"
				--	keymap.set("n", "<leader>cD", "<cmd>FzfLua diagnostics_document bufnr=0<CR>", opts) -- show diagnostics for file

				--	opts.desc = "Line diagnostics"
				--	keymap.set("n", "<leader>cd", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Cursor documentation"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				--	opts.desc = "Restart LSP"
				--	keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			--
			--		["zls"] = function()
			--			-- configure Zig server
			--			lspconfig["zls"].setup({
			--				capabilities = capabilities,
			--				on_attach = function(client, bufnr)
			--					vim.api.nvim_create_autocmd("BufWritePost", {
			--						pattern = { "*.zig" },
			--						callback = function(ctx)
			--							-- Here use ctx.match instead of ctx.file
			--							-- client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
			--						end,
			--					})
			--				end,
			--			})
			--		end,
			--
			["verible"] = function()
				-- configure Zig server
				lspconfig["verible"].setup({
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePost", {
							pattern = { "*.v" },
							callback = function(ctx)
								-- Here use ctx.match instead of ctx.file
								-- client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
							end,
						})
					end,
				})
			end,

			["lua_language_server"] = function()
				-- configure Lua server
				lspconfig["lua_language_server"].setup({
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePost", {
							pattern = { "*.lua" },
							callback = function(ctx)
								-- Here use ctx.match instead of ctx.file
								-- client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
							end,
						})
					end,
				})
			end,

			["asm_lsp"] = function()
				-- configure asm server
				lspconfig["asm_lsp"].setup({
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePost", {
							pattern = { "*.asm" },
							callback = function(ctx)
								-- Here use ctx.match instead of ctx.file
								-- client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
							end,
						})
					end,
				})
			end,

			--["lua_ls"] = function()
			--	-- configure lua server (with special settings)
			--	lspconfig["lua_ls"].setup({
			--		capabilities = capabilities,
			--		settings = {
			--			Lua = {
			--				-- make the language server recognize "vim" global
			--				diagnostics = {
			--					globals = { "vim" },
			--				},
			--				completion = {
			--					callSnippet = "Replace",
			--				},
			--			},
			--		},
			--	})
			--end,
		})
	end,
}
