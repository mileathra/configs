return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")
		local _ = dap

		require("dap-go").setup()
		require("nvim-dap-virtual-text").setup()

		vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>")
		vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<CR>")
		vim.keymap.set("n", "<leader>de", "<cmd>DapEval<CR>")
	end,
}
