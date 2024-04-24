local wk = require("which-key")
wk.register({
	["<leader>"] = {

		-- Buffer
		b = {
			name = "Buffer",
			o = { "<cmd>%bd|e#|bd#<cr><cr>", "Close All Others" },
			c = { "<cmd>bp|bdel #<cr>", "Close" },
			A = { "<cmd>%bdel<cr>", "Close All" },
			F = { "<cmd>bdel!<cr>", "Force Close" },
		},

		-- code
		c = {
			name = "Code",
			i = { "<cmd>LspInfo<cr>", "LSP Info" },
		},
		-- Config files
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
			s = { "<cmd>FzfLua git_status<cr>", "Status" },
			g = { "<cmd>Neogit kind=auto<cr>", "Neogit" },
		},

		w = {
			name = "Window",
			m = { "<cmd>MaximizerToggle<CR>", "Maximize/Minimize a split" },
			l = { "<cmd>SessionRestore<CR>", "Load session for current Dir" },
			s = { "<cmd>SessionSave<CR>", "Save session for current Dir" },
		},

		s = {
			name = "Search",
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
