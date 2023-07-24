return {
	{
		"rcarriga/neotest",
		event = "VeryLazy",
		config = function()
			local status_ok, neotest = pcall(require, "neotest")

			if not status_ok then
				return
			end

			local opts = { noremap = true, silent = true }
			local mappings = {
				{
					"n",
					"<leader>tt",
					function()
						neotest.run.run(vim.fn.expand("%"))
					end,
					opts,
				},
				{
					"n",
					"<leader>ts",
					function()
						neotest.summary.toggle()
					end,
					opts,
				},
				{
					"n",
					"<leader>tT",
					function()
						require("neotest").run.run(vim.loop.cwd())
					end,
					opts,
				},
				{
					"n",
					"<leader>tr",
					function()
						require("neotest").run.run()
					end,
					opts,
				},
				{
					"n",
					"<leader>ts",
					function()
						require("neotest").summary.toggle()
					end,
					opts,
				},
				{
					"n",
					"<leader>to",
					function()
						require("neotest").output.open({ enter = true, auto_close = true })
					end,
					opts,
				},
				{
					"n",
					"<leader>tO",
					function()
						require("neotest").output_panel.toggle()
					end,
					opts,
				},
				{
					"n",
					"<leader>tS",
					function()
						require("neotest").run.stop()
					end,
					opts,
				},
			}

			for _, m in pairs(mappings) do
				vim.keymap.set(unpack(m))
			end

			neotest.setup({
				adapters = {
					require("neotest-go"),
					require("neotest-jest"),
					require("neotest-vitest"),
				},
				consumers = {
					always_open_output = function(client)
						local async = require("neotest.async")
						client.listeners.results = function(adapter_id, results)
							local file_path = async.fn.expand("%:p")
							local row = async.fn.getpos(".")[2] - 1
							local position = client:get_nearest(file_path, row, {})
							if not position then
								return
							end
							local pos_id = position:data().id
							if not results[pos_id] then
								return
							end
							neotest.output.open({ position_id = pos_id, adapter = adapter_id })
						end
					end,
				},
			})
		end,
		dependencies = {
			{ "haydenmeade/neotest-jest", event = "VeryLazy" },
			{ "marilari88/neotest-vitest", event = "VeryLazy" },
			{ "nvim-neotest/neotest-go", event = "VeryLazy" },
		},
	},
}
