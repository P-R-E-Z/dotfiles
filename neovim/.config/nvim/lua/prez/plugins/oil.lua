return {
    'stevearc/oil.nvim',
    lazy = false,
    dependencies = {
        { "echasnovski/mini.icons", opts = {} },
    },
    config = function()
        require("oil").setup({
            columns = {
                "icon",
                "size",
            },
            skip_confirm_for_simple_edits = true,
            delete_to_trash = true,
            view_options = {
                show_hidden = true,
            },
            keymaps = {
                ["<Esc>"] = { "actions.close", mode = "n" },
            },
        })
    end,
}
