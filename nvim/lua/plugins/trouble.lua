return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	keys = {
		{ "<leader>cx", "<cmd>TroubleToggle<CR>", desc = "Open/close trouble list" },
		{ "<leader>cw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace diagnostics" },
		{ "<leader>cd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Document diagnostics" },
		{ "<leader>cq", "<cmd>TroubleToggle quickfix<CR>", desc = "Quickfix list" },
		--   { "<leader>xl", "<cmd>TroubleToggle loclist<CR>", desc = "Open trouble location list" },
		{ "<leader>ct", "<cmd>TodoTrouble<CR>", desc = "Open TODOs" },
	},
}
