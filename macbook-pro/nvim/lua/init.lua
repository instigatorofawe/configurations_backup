require('autoclose').setup()

require('mason').setup{}
require('mason-lspconfig').setup{
    ensure_installed = {
        "lua_ls", "marksman", "bashls", "texlab", "rust_analyzer"
    }
}

require('monokai-pro').setup{}

require('lualine').setup{extensions={'chadtree'}}
require('leap').add_default_mappings()

vim.g.coq_settings = {
    auto_start = 'shut-up'
}

require('coq')

-- if vim.fn.executable('pyright') == 1 then
--     require'lspconfig'.pyright.setup{}
-- end

if vim.fn.executable('basedpyright') == 1 then
    require'lspconfig'.basedpyright.setup{}
end

-- if vim.fn.executable('R') == 1 then
--     require'lspconfig'.r_language_server.setup{}
-- end

-- if vim.fn.executable('sourcekit-lsp') == 1 then
--     require'lspconfig'.sourcekit.setup{}
-- end

require'lspconfig'.marksman.setup{}
require'lspconfig'.lua_ls.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.texlab.setup{}
require'lspconfig'.rust_analyzer.setup{

    on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, {bufnr})
    end
    
}

