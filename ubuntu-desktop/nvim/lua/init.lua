require('mason').setup{}
require('mason-lspconfig').setup {
    ensure_installed = { "lua_ls", "marksman", "ltex" }
}

require('lualine').setup{extensions={'chadtree'}}
require('leap').add_default_mappings()
require('autoclose').setup()

vim.g.coq_settings = { auto_start = 'shut-up' }

require('coq')

if vim.fn.executable('pyright') == 1 then
    require'lspconfig'.pyright.setup{}
end

if vim.fn.executable('R') == 1 then
    require'lspconfig'.r_language_server.setup{}
end

require'lspconfig'.lua_ls.setup{}
require'lspconfig'.marksman.setup{}
require'lspconfig'.ltex.setup{}
