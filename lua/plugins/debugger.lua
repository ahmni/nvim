return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"theHamsta/nvim-dap-virtual-text",
			"jay-babu/mason-nvim-dap.nvim",
			"folke/neodev.nvim",
		},
		config = function()
			require("neodev").setup({
				library = { plugins = { "nvim-dap-ui" }, types = true },
				lspconfig = true,
				pathStrict = true,
			})
			local dap, dapui = require("dap"), require("dapui")
			require("nvim-dap-virtual-text").setup()
			dapui.setup({ icons = { expanded = "▾", collapsed = "▸" } })
			dap.listeners.before.attach.dapui_config = function() dapui.open() end
			dap.listeners.before.launch.dapui_config = function() dapui.open() end
			dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
			dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
		end,
		keys = {
			{
				"<leader>db",
				"<cmd> DapToggleBreakpoint<CR>",
				"[D]ebugger [B]reakpoint",
			},
			{
				"<leader>dB",
				"<cmd> lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) <CR>",
				"[D]ebugger [B]reakpoint",
			},
			{
				"<leader>dc",
				"<cmd> DapContinue<CR>",
				"[D]ebugger [C]ontinue",
			},
			{
				"<leader>di",
				"<cmd> DapStepInto<CR>",
				"[D]ebugger [I]ext",
			},
			{
				"<leader>do",
				"<cmd> DapStepOut<CR>",
				"[D]ebugger [O]ut",
			},
			{
				"<leader>dn",
				"<cmd> DapStepOver<CR>",
				"[D]ebugger [N]ext",
			},
			{
				"<leader>dh",
				"<cmd> lua require('dapui').eval()<CR>",
				"[D]ebugger [H]over",
			},
		},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
			"williamboman/mason.nvim",
		},
		opts = {
			handlers = {
				function(config)
					-- all sources with no handler get passed here

					-- Keep original functionality
					require("mason-nvim-dap").default_setup(config)
				end,
				codelldb = function(config)
					config.configurations = {
						{
							name = "Launch",
							type = "codelldb",
							request = "launch",
							program = function()
								return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build", "file")
							end,
							args = {},
							cwd = "${workspaceFolder}/build/",
							stopAtEntry = false,
							environment = {},
							externalConsole = false,
							MIMode = "gdb",
							setupCommands = {
								{
									description = "Enable pretty-printing for gdb",
									text = "-enable-pretty-printing",
									ignoreFailures = true,
								},
							},
						},
					}
					require("mason-nvim-dap").default_setup(config) -- don't forget this!
				end,
			},
		},
	},
}
