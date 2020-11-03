local cmp = require('cmp')
local compare = require('cmp.config.compare')
local lspkind = require('lspkind')

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

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
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if vim.fn['UltiSnips#CanJumpBackwards']() == 1 then
                vim.fn.feedkeys(t('<C-R>=UltiSnips#JumpBackwards()<CR>'))
            elseif vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(t('<C-p>'), 'n')
            else
                vim.fn.feedkeys(t('<S-tab>'), 'n')
            end
        end, {
            'i',
            's',
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if vim.fn['UltiSnips#CanJumpForwards']() == 1 then
                vim.fn.feedkeys(t('<esc>:call UltiSnips#JumpForwards()<CR>'))
            elseif vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(t('<C-n>'), 'n')
            else
                vim.fn.feedkeys(t('<tab>'), 'n')
            end
        end, {
            'i',
            's',
        }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }),
        ['<C-Space>'] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                if vim.fn.complete_info()['selected'] ~= -1 then
                    if vim.fn['UltiSnips#CanExpandSnippet']() == 1 then
                        return vim.fn.feedkeys(t('<C-R>=UltiSnips#ExpandSnippet()<CR>'))
                    else
                        vim.fn.feedkeys(t('<cr>'), 'n')
                    end
                else
                    vim.fn.feedkeys(t('<C-e>'), 'n')
                end
            else
                cmp.complete()
            end
        end, {
            'i',
            's',
        }),
    },
    sources = {
        { name = 'cmp_tabnine' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'ultisnips' },
        { name = 'nvim_lua' },
        { name = 'path' },
        { name = 'calc' },
    },
    sorting = {
        priority_weight = 1.5,
        comparators = {
            compare.score,
            compare.offset,
        },
    },
})

require('nvim-autopairs.completion.cmp').setup({
    map_cr = true,
    map_complete = true,
    auto_select = false,
})
