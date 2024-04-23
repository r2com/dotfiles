--local M = {}
--
--local function map(mode, l, r, desc, buffer)
--	vim.keymap.set(mode, l, r, { buffer = buffer or true, desc = desc })
--end
--
--function M.lsp_attach(buffer)
--	local lsp = vim.lsp.buf
--	local fzf = function(func)
--		return string.format("<cmd>FzfLua %s jump_to_single_result=true<cr>", func)
--	end
--	local pfx = "LSP: "
--	local function bmap(mode, l, r, desc)
--		map(mode, l, r, desc, buffer)
--	end
--
--	bmap("n", "<leader>ca", lsp.code_action, pfx .. "Code Action")
--	bmap("n", "<leader>cd", fzf("lsp_workspace_diagnostics"), pfx .. "Diagnostics")
--	bmap("n", "<leader>cr", lsp.rename, pfx .. "Rename")
--	bmap("n", "<leader>cs", fzf("lsp_document_symbols"), pfx .. "Document Symbols")
--	bmap("n", "gd", fzf("lsp_definitions"), pfx .. "Goto Definition")
--	bmap("n", "gr", fzf("lsp_references"), pfx .. "Goto References")
--	bmap("n", "gD", lsp.declaration, pfx .. "Goto Declaration")
--	bmap("n", "gI", fzf("lsp_implementations"), pfx .. "Goto Implementations")
--	bmap("n", "gy", fzf("lsp_typedefs"), pfx .. "Goto Type Definition")
--	bmap("n", "K", lsp.hover, pfx .. "Hover Documentation")
--	bmap("n", "gK", lsp.signature_help, pfx .. "Signature Help")
--	bmap("i", "<C-k>", lsp.signature_help, pfx .. "Signature Help")
--end

local wk = require("which-key")
wk.register({
	["<leader>"] = {
		-- Alternate buffer
		a = { "<cmd>e #<cr>", "Alternate Buffer" },

		-- Buffer
		b = {
			name = "Buffer",
			a = { "<cmd>e #<cr>", "Previous Buffer" },
			c = { "<cmd>%bd|e#|bd#<cr><cr>", "Close All Others" },
			d = { "<cmd>bp|bdel #<cr>", "Close" },
			A = { "<cmd>%bdel<cr>", "Close All" },
			D = { "<cmd>bdel!<cr>", "Force Close" },
		},
		--  c = {
		--    name = "Code",
		--    l = { "<cmd>LspInfo<cr>", "LSP Info" },
		--    f = {
		--      function()
		--        require("conform").format()
		--      end,
		--      "Format",
		--    },
		--  },
		--  -- Config files
		C = {
			function()
				require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
			end,
			"Config Files",
		},

		e = {
			function()
				require("oil").toggle_float()
			end,
			"File Explorer",
		},
		f = {
			name = "Find/File",
			H = { "<cmd>FzfLua files cwd=~<cr>", "Find Files (home)" },
			b = { "<cmd>FzfLua buffers<cr>", "Find Buffers" },
			f = { "<cmd>FzfLua files<cr>", "Find Files" },
			j = { "<cmd>FzfLua jumps<cr>", "Jumplist" },
			l = { "<cmd>FzfLua resume<cr>", "Last Search" },
			n = { "<cmd>enew<cr>", "New File" },
			r = { "<cmd>FzfLua oldfiles<cr>", "Open Recent Files" },
			t = { "<cmd>FzfLua tabs<cr>", "Find Tabs" },
		},
		g = {
			name = "Git",
			b = { "<cmd>FzfLua git_branches<cr>", "Branches" },
			c = { "<cmd>FzfLua git_commits<cr>", "Commits" },
			C = { "<cmd>FzfLua changes<cr>", "Changes" },
			g = { "<cmd>Neogit kind=auto<cr>", "Neogit" },
			h = { "Hunks" },
			s = { "<cmd>FzfLua git_status<cr>", "Status" },
			t = { "<cmd>FzfLua tags<cr>", "Tags" },
		},

		s = {
			name = "Search",
			b = { "<cmd>FzfLua cur_buf<cr>", "Grep Current Buffer" },
			c = { "<cmd>FzfLua commands<cr>", "Commands" },
			g = { "<cmd>FzfLua live_grep<cr>", "Grep" },
			h = { "<cmd>FzfLua help_tags<cr>", "Help Tags" },
			k = { "<cmd>FzfLua keymaps<cr>", "Keymaps" },
			m = { "<cmd>FzfLua man_pages<cr>", "Man Pages" },
			s = { "<cmd>FzfLua spell_suggest<cr>", "Spell Suggestions" },
			w = { "<cmd>FzfLua grep_cword<cr>", "Grep Word Under Cursor" },
			["/"] = { "<cmd>FzfLua search_history<cr>", "Search History" },
		},
		--   t = {
		--     name = "Tmux",
		--     b = { "<cmd>FzfLua tmux_buffers<cr>", "Tmux Paste Buffers" },
		--     f = { "<cmd>TmuxFilePaths<cr>", "Tmux File Paths" },
		--   },

		[" "] = { "<cmd>FzfLua files<cr>", "Find Files" },
		["/"] = {
			{ "<cmd>FzfLua live_grep<cr>", "Grep" },
			{ "<cmd>FzfLua grep_visual<cr>", "Grep", mode = "v" },
		},
		["\\"] = { "<cmd>vsplit | terminal<cr>", "Terminal" },
		['"'] = { "<cmd>FzfLua registers<cr>", "Registers" },
	},

	-- Move to tmux window using the <ctrl> hjkl keys
	--  ["<C-h>"] = { mode = { "n", "i", "x", "t" }, "<cmd>SmartCursorMoveLeft<cr>", "Go to left window" },
	--  ["<C-j>"] = { mode = { "n", "i", "x", "t" }, "<cmd>SmartCursorMoveDown<cr>", "Go to lower window" },
	--  ["<C-k>"] = { mode = { "n", "i", "x", "t" }, "<cmd>SmartCursorMoveUp<cr>", "Go to upper window" },
	--  ["<C-l>"] = { mode = { "n", "i", "x", "t" }, "<cmd>SmartCursorMoveRight<cr>", "Go to right window" },

	-------------------------------------------------------------------------------
	-- Buffers
	-------------------------------------------------------------------------------
	H = { "<cmd>bprev<cr>", "Previous Buffer" },
	L = { "<cmd>bnext<cr>", "Next Buffer" },
	["<C-b>"] = { "<cmd>FzfLua buffers<cr>", "Find Buffers" },

	-------------------------------------------------------------------------------
	-- Escape
	-------------------------------------------------------------------------------
	["<esc>"] = {
		{ mode = { "n", "i" }, "<cmd>noh<cr><esc>", "Clear Search Highlighting" },
		{ mode = { "t" }, "<C-\\><C-n>", "Escape terminal mode" },
	},
})

-------------------------------------------------------------------------------
-- Moving lines
-------------------------------------------------------------------------------
wk.register({
	["<A-j>"] = { "<cmd>m .+1<cr>==", "Move Line down" },
	["<A-k>"] = { "<cmd>m .-2<cr>==", "Move Line up" },
}, { mode = "n" })
wk.register({
	["<A-j>"] = { "<esc><cmd>m .+1<cr>==gi", "Move Line down" },
	["<A-k>"] = { "<esc><cmd>m .-2<cr>==gi", "Move Line up" },
}, { mode = "i" })
wk.register({
	["<A-j>"] = { "<cmd>m '>+1<cr>gv=gv", "Move Lines Down" },
	["<A-k>"] = { "<cmd>m '<-2<cr>gv=gv", "Move Lines Up" },
}, { mode = "v" })

--return M
