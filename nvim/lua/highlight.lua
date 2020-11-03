local hls = {}

local function create(group, color)
    local gui = color.gui and 'gui = ' .. color.gui or 'gui = NONE'
    local fg = color.fg and 'guifg = ' .. color.fg or 'guifg = NONE'
    local bg = color.bg and 'guibg = ' .. color.bg or 'guibg = NONE'
    local sp = color.sp and 'guisp = ' .. color.sp or ''
    vim.cmd('highlight ' .. group .. ' ' .. gui .. ' ' .. fg .. ' ' .. bg .. ' ' .. sp)
end

for hl, color in pairs(hls) do
    create(hl, color)
end
