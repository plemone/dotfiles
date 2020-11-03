local vim = vim

local M = {}

local function cleanup_buffers()
    local bufs = vim.api.nvim_list_bufs()
    for _, buf in ipairs(bufs) do
        local name = vim.api.nvim_buf_get_name(buf)
        if not name or name == '' then
            vim.api.nvim_buf_delete(buf, {
                force = true,
            })
        end
    end
end

M.convert_tabs_to_spaces = function()
    vim.cmd([[retab]])
end

M.remove_trailing_whitespaces = function()
    vim.cmd([[%s/\s\+$//e]])
end

M.close_all_buffers = function()
    vim.cmd([[bufdo bd]])
end

M.remove_unwanted_files = function()
    local unwanted_files = { '.DS_Store' }
    for _, unwanted_file in pairs(unwanted_files) do
        vim.cmd('!find . -name "' .. unwanted_file .. '" -delete')
    end
end

M.live_grep = function()
    vim.cmd([[:Telescope live_grep]])
end

M.find_files = function()
    vim.cmd([[:Telescope find_files theme=get_ivy]])
end

M.git_status = function()
    vim.cmd([[:Telescope git_status theme=get_ivy]])
end

M.list_buffers = function()
    vim.cmd('Telescope buffers theme=get_ivy')
end

M.help_tags = function()
    vim.cmd([[:Telescope help_tags theme=get_ivy]])
end

M.clear = function()
    vim.cmd([[noh]])
end

M.refresh = function()
    cleanup_buffers()
end

M.save = function()
    vim.cmd([[w]])
end

M.set_colorscheme = function(colorscheme)
    vim.cmd(string.format('colorscheme %s', colorscheme))
    vim.cmd([[:VGit apply_highlights]])
end

M.fix_indent = function()
    vim.api.nvim_input('gg=G')
end

M.set_indent = function(width)
    width = tonumber(width)
    vim.o.tabstop = width
    vim.o.softtabstop = width
    vim.o.shiftwidth = width
    vim.o.expandtab = true
end

M.toggle_tree = function()
    vim.cmd([[:NvimTreeToggle]])
    vim.cmd([[:NvimTreeRefresh]])
end

M._command_autocompletes = function(arglead, line)
    local parsed_line = #vim.split(line, '%s+')
    local matches = {}
    if parsed_line == 2 then
        for func, _ in pairs(M) do
            if not vim.startswith(func, '_') and vim.startswith(func, arglead) then
                matches[#matches + 1] = func
            end
        end
    end
    return matches
end

M._run_command = function(command, ...)
    local starts_with = command:sub(1, 1)
    if starts_with == '_' or not M[command] or not type(M[command]) == 'function' then
        error('invalid command')
        return
    end
    return M[command](...)
end

vim.cmd(
    string.format(
        'com! -nargs=+ %s %s',
        '-complete=customlist,v:lua.package.loaded.actions._command_autocompletes',
        'Actions lua require("actions")._run_command(<f-args>)'
    )
)

return M
