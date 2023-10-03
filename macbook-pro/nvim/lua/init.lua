require('lualine').setup{extensions={'chadtree'}}
require('leap').add_default_mappings()

vim.g.coq_settings = {
    auto_start = 'shut-up'
}

require('coq')

if vim.fn.executable('pyright') == 1 then
    require'lspconfig'.pyright.setup{}
end

if vim.fn.executable('lua-language-server') == 1 then
    require'lspconfig'.lua_ls.setup{}
end

if vim.fn.executable('R') == 1 then
    require'lspconfig'.r_language_server.setup{}
end

if vim.fn.executable('sourcekit-lsp') == 1 then
    require'lspconfig'.sourcekit.setup{}
end

