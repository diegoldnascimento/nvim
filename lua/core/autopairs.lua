-- A super powerful autopair plugin for Neovim that supports multiple characters.--
local status_ok, autopairs = pcall(require, "nvim-autopairs")

if not status_ok then
	return
end

autopairs.setup({
	check_ts = true,
	disable_filetype = { "TelescopePrompt", "vim" },
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
