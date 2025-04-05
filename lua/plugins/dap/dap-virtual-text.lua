local status_ok, dapv = pcall(require, "nvim-dap-virtual-text")

if not status_ok then
	return
end

dapv.setup({
	enabled = true,
	commented = true,
})
