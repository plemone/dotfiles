require('toggleterm').setup({
    size = function()
        return vim.o.columns * 0.3
    end,
    open_mapping = [[<c-\>]],
    direction = 'vertical',
})
