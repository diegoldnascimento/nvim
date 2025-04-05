return {
	"nvchad/nvim-colorizer.lua",
	opts = {
		filetypes = { "*" },
		user_default_options = {
			RGB = true,
			RRGGBB = true,
			names = true,
			RRGGBBAA = false,
			AARRGGBB = false,
			rgb_fn = false,
			hsl_fn = false,
			css = false,
			css_fn = false,
			mode = "background",
			virtualtext = "■",
			always_update = false,
		},
		buftypes = {},
	},
	config = function(_, opts)
		require("colorizer").setup(opts)
	end,
}
