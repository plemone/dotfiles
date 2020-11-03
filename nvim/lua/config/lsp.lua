local vim = vim

local function setup_servers()
    require('lspinstall').setup()
    local lspconf = require('lspconfig')
    local servers = require('lspinstall').installed_servers()
    local lsp_spec = {
        lua = function(lang)
            lspconf[lang].setup({
                root_dir = function()
                    return vim.loop.cwd()
                end,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                                [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                            },
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })
        end,
        tsserver = function(lang)
            lspconf[lang].setup({
                on_attach = function(client)
                    if client.config.flags then
                        client.config.flags.allow_incremental_sync = true
                    end
                    client.resolved_capabilities.document_formatting = false
                end,
            })
        end,
        efm = function(lang)
            lspconf[lang].setup({
                on_attach = function(client)
                    client.resolved_capabilities.document_formatting = true
                    client.resolved_capabilities.goto_definition = false
                end,
            })
        end,
        diagnosticls = function(lang)
            lspconf[lang].setup({
                filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css' },
                init_options = {
                    filetypes = {
                        javascript = 'eslint',
                        typescript = 'eslint',
                        javascriptreact = 'eslint',
                        typescriptreact = 'eslint',
                    },
                    linters = {
                        eslint = {
                            sourceName = 'eslint',
                            command = './node_modules/.bin/eslint',
                            rootPatterns = {
                                '.eslitrc.js',
                                'package.json',
                            },
                            debounce = 100,
                            args = {
                                '--cache',
                                '--stdin',
                                '--stdin-filename',
                                '%filepath',
                                '--format',
                                'json',
                            },
                            parseJson = {
                                errorsRoot = '[0].messages',
                                line = 'line',
                                column = 'column',
                                endLine = 'endLine',
                                endColumn = 'endColumn',
                                message = '${message} [${ruleId}]',
                                security = 'severity',
                            },
                            securities = {
                                [2] = 'error',
                                [1] = 'warning',
                            },
                        },
                    },
                },
            })
        end,
    }
    for _, lang in pairs(servers) do
        local spec = lsp_spec[lang]
        if spec ~= nil then
            spec(lang)
        else
            lspconf[lang].setup({
                root_dir = vim.loop.cwd,
            })
        end
    end
end

setup_servers()

require('lspinstall').post_install_hook = function()
    setup_servers()
    vim.cmd('bufdo e')
end

require('trouble').setup()

vim.fn.sign_define('LspDiagnosticsSignError', { text = '', numhl = 'LspDiagnosticsDefaultError' })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text = '', numhl = 'LspDiagnosticsDefaultWarning' })
vim.fn.sign_define('LspDiagnosticsSignInformation', { text = '', numhl = 'LspDiagnosticsDefaultInformation' })
vim.fn.sign_define('LspDiagnosticsSignHint', { text = '', numhl = 'LspDiagnosticsDefaultHint' })
