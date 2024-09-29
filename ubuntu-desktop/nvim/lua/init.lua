require('autoclose').setup()

require('mason').setup{}
require('mason-lspconfig').setup{
    ensure_installed = {
        "lua_ls", "marksman", "bashls", "texlab", "rust_analyzer"
    }
}

require('monokai-pro').setup{}

require('nvim-tree').setup{}
require('lualine').setup{extensions={'nvim-tree'}}
require('leap').add_default_mappings()

require('quarto').setup{}
require('otter').setup{
    buffers = {
        set_filetype = true,
        write_to_disk = true
    }
}

local cmp = require('cmp')

cmp.setup({
    snippet = {-- REQUIRED - you must specify a snippet engine 
        expand = function(args) 
            vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+) 
        end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({ 
        ['<C-b>'] = cmp.mapping.scroll_docs(-4), 
        ['<C-f>'] = cmp.mapping.scroll_docs(4), 
        ['<C-Space>'] = cmp.mapping.complete(), 
        ['<C-e>'] = cmp.mapping.abort(), 
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({ 
        { name = 'nvim_lsp' }, 
    }, { 
        { name = 'buffer' }, 
    }) 
})

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]-- 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, { 
    mapping = cmp.mapping.preset.cmdline(), 
    sources = { 
        { name = 'buffer' } 
    }
})

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', { 
    mapping = cmp.mapping.preset.cmdline(), 
    sources = cmp.config.sources({ 
        { name = 'path' } 
    }, { 
        { name = 'cmdline' } 
    }), 
    matching = { disallow_symbol_nonprefix_matching = false } 
})

  -- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require'lspconfig'.marksman.setup{
    capabilities = capabilities
}
require'lspconfig'.lua_ls.setup{
    capabilities = capabilities
}
require'lspconfig'.bashls.setup{
    capabilities = capabilities
}
require'lspconfig'.texlab.setup{
    capabilities = capabilities
}
require'lspconfig'.rust_analyzer.setup{
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, {bufnr})
    end
}

if vim.fn.executable('basedpyright') == 1 then
    require'lspconfig'.basedpyright.setup{
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            vim.lsp.inlay_hint.enable(true, {bufnr})
        end
    }
end

if vim.fn.executable('R') == 1 then
    require'lspconfig'.r_language_server.setup{
        capabilities = capabilities
    }
end

