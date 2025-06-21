return {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
	require("nord").setup({
	    transparent = false,
	    terminal_colors = true,
	    diff = { mode = "bg" },
	    borders = true,
	    errors = { mode = "bg" },
	    search = { theme = "vim" },
	    styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = { italic = true },
		variables = {},
		bufferline = {
		    current = {},
		    modified = { italic = true },
		},
	    },
	    on_colors = function(colors) end,

	    on_highlights = function(highlights, colors)
		highlights.Comment = {
		    fg = "#001133",
		    italic = true,
		}
	    end,
	})

	vim.cmd.colorscheme("nord") 
    
	-- Highlight override for transparent terminals
	vim.api.nvim_set_hl(0, "Comment", { fg = "#002233", italic = true })
	vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
    end,
}
