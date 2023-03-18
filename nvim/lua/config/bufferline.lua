vim.opt.mousemoveevent = true
require("bufferline").setup({
    options = {
        hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
        },
        close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        separator_style = "slant", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
        show_tab_indicators = true,
        toggle_hidden_on_enter = true,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or ""
            return " " .. icon .. count
        end, -- numbers = function(opts)
        --     return string.format("%s·%s", opts.raise(opts.id), opts.lower(opts.ordinal))
        -- end,
        always_show_bufferline = false,
    },
})
