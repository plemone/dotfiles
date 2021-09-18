local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind] .. ' ' .. vim_item.kind
            vim_item.menu = ({
                cmp_tabnine = '[T9]',
                nvim_lsp = '[LSP]',
                ultisnips = '[USnip]',
                nvim_lua = '[LUA]',
                buffer = '[Buffer]',
                path = '[Path]',
                calc = '[Calc]',
            })[entry.source.name]
            return vim_item
        end,
    },
    documentation = {
        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    },
    min_length = 0,
    sources = {
        { name = 'cmp_tabnine' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'ultisnips' },
        { name = 'nvim_lua' },
        { name = 'path' },
        { name = 'calc' },
    },
})

require('nvim-autopairs.completion.cmp').setup({
    map_cr = true,
    map_complete = true,
    auto_select = false,
})
