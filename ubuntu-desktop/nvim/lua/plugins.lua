vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- Add Plugins here
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    use 'm4xshen/autoclose.nvim'

    use {'ms-jpq/coq_nvim', branch='coq'}
    use {'ms-jpq/coq.artifacts', branch='artifacts'}
    use {'ms-jpq/coq.thirdparty', branch='3p'}
    use {'ms-jpq/chadtree', branch='chad'}

    use {'lewis6991/gitsigns.nvim', config=function() require('gitsigns').setup() end}
    use {'nvim-lualine/lualine.nvim', requires={'kyazdani42/nvim-web-devicons', opt=true}}
    use {'numToStr/Comment.nvim', config=function() require('Comment').setup() end}
    use {'nvim-telescope/telescope.nvim', tag='0.1.0', requires={{'nvim-lua/plenary.nvim'}}}

    use 'nvim-tree/nvim-web-devicons'
    use 'ggandor/leap.nvim'

    vim.cmd([[
      augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
      augroup end
    ]])

end)
