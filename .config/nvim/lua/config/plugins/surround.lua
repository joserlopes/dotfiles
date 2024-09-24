return {
	"echasnovski/mini.surround",
	opts = {
		-- Add custom surroundings to be used on top of builtin ones. For more
		-- information with examples, see `:h MiniSurround.config`.
		custom_surroundings = nil,

		-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
		highlight_duration = 500,

		-- Number of lines within which surrounding is searched
		n_lines = 20,

		-- Whether to respect selection type:
		-- - Place surroundings on separate lines in linewise mode.
		-- - Place surroundings on each line in blockwise mode.
		respect_selection_type = false,

		-- How to search for surrounding (first inside current line, then inside
		-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
		-- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
		-- see `:h MiniSurround.config`.
		search_method = "cover",

		-- Whether to disable showing non-error feedback
		silent = false,
	},
}
