vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'

    use 'm4xshen/autoclose.nvim'
    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
      require("toggleterm").setup()
    end}

    use {'ms-jpq/coq_nvim', branch='coq'}
    use {'ms-jpq/coq.artifacts', branch='artifacts'}
    use {'ms-jpq/coq.thirdparty', branch='3p'}
    use {'ms-jpq/chadtree', branch='chad'}

    use {'nvim-lualine/lualine.nvim', requires={'kyazdani42/nvim-web-devicons', opt=true}}
    use {'numToStr/Comment.nvim', config=function() require('Comment').setup() end}
    use {'lewis6991/gitsigns.nvim', config=function() require('gitsigns').setup() end}
    use {'nvim-telescope/telescope.nvim', requires={{'nvim-lua/plenary.nvim'}}}

    use 'nvim-tree/nvim-web-devicons'
    use 'ggandor/leap.nvim'
    use 'loctvl842/monokai-pro.nvim'


    vim.cmd([[
      augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
      augroup end
    ]])

end)
