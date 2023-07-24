local status_ok, copilot = pcall(require, "copilot")

if not status_ok then
	return
end

copilot.setup({
	suggestion = {
		enabled = true,
		auto_trigger = true,
		debounce = 75,
		keymap = {
			accept = "<c-o>",
		},
	},
	panel = { enabled = true, auto_refresh = false },
})
