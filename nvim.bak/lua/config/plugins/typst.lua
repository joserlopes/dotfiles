return {
	"chomosuke/typst-preview.nvim",
	ft = "typst",
	version = "1.*",
	opts = {
		open_cmd = "qutebrowser %s",
		dependencies_bin = {
			["tinymist"] = "tinymist",
		},
	},
}
