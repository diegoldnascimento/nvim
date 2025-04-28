return {
	{
		"Davidyz/VectorCode",
		version = "*", -- optional, depending on whether you're on nightly or release
		build = "pipx upgrade vectorcode", -- optional but recommended if you set `version = "*"`
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			n_query = 1, -- number of retrieved documents
			notify = true, -- enable notifications
			timeout_ms = 5000, -- timeout in milliseconds for the query operation.
			exclude_this = false, -- exclude the buffer from which the query is called.
			-- This avoids repetition when you change some code but
			-- the embedding has not been updated.
		},
		cond = function()
      return false
			-- return vim.fn.executable("vectorcode") == 1
		end,
	},
}
