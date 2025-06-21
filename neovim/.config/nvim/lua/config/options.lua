-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Tabbing
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 4 -- Amount to indent with << & >>
vim.opt.tabstop = 4 -- How many spaces are shown per tab
vim.opt.softtabstop = 4 -- How many spaces applied when using Tab
vim.opt.smarttab = true

-- Indenting
vim.opt.smartindent = true
vim.opt.autoindent = true -- Keep indentation from prev line
vim.opt.breakindent = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Enable mouse mode
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Config how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how nvim will display certain whitespace characters
--  See `:help 'list'` and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

-- Format Options fix
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- Highlight text for some time after yanking
vim.api.nvim_create_autocmd("TextYankPost", { 
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end,
    desc = "Highlight yank",
})
