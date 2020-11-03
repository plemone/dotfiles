local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    execute('packadd packer.nvim')
end

return require('packer').startup(function()
    local use = use
    use('tanvirtin/vgit.nvim')
    use('nvim-lua/popup.nvim')
    use('tpope/vim-commentary')
    use('neovim/nvim-lspconfig')
    use('nvim-lua/plenary.nvim')
    use('tanvirtin/monokai.nvim')
    use('kabouzeid/nvim-lspinstall')
    use('nvim-telescope/telescope.nvim')
    use('kyazdani42/nvim-web-devicons')
    use('kyazdani42/nvim-tree.lua')
    use('kosayoda/nvim-lightbulb')
    use('folke/tokyonight.nvim')
    use('norcalli/nvim-colorizer.lua')
    use('windwp/nvim-autopairs')
    use('JoosepAlviste/nvim-ts-context-commentstring')
    use({ 'wbthomason/packer.nvim', opt = true })
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
    use('numtostr/FTerm.nvim')
    use('morhetz/gruvbox')
    use('kevinhwang91/nvim-bqf')
    use('folke/trouble.nvim')
    use('mhartington/formatter.nvim')
    use('hoob3rt/lualine.nvim')
    use('akinsho/bufferline.nvim')
    use('phaazon/hop.nvim')
    use('akinsho/nvim-toggleterm.lua')
    use('dstein64/vim-startuptime')
    use('karb94/neoscroll.nvim')
    use({
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/vim-vsnip',
            'hrsh7th/cmp-buffer',
        },
    })
    use('onsails/lspkind-nvim')
end)
