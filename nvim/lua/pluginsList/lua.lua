-- check if packer is installed (~/local/share/nvim/site/pack)
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

-- using { } when using a different branch of the plugin or loading the plugin with certain commands
return require("packer").startup(
    function()
        use {"wbthomason/packer.nvim", opt = true}
        use {"lukas-reineke/indent-blankline.nvim", branch = "lua"}

        -- color related stuff
        use "norcalli/nvim-base16.lua"
        use "norcalli/nvim-colorizer.lua"
        -- lsp stuff
        use "nvim-treesitter/nvim-treesitter"
        use "neovim/nvim-lspconfig"
        use "hrsh7th/nvim-compe"
        use "onsails/lspkind-nvim"
        use "sbdchd/neoformat"
        use "nvim-lua/plenary.nvim"

        use "lewis6991/gitsigns.nvim"
        use "akinsho/nvim-bufferline.lua"
        use "glepnir/galaxyline.nvim"
        use "windwp/nvim-autopairs"
        use "alvan/vim-closetag"

        -- file managing , picker etc
        use "kyazdani42/nvim-tree.lua"
        use "kyazdani42/nvim-web-devicons"
        use "ryanoasis/vim-devicons"
        use "nvim-telescope/telescope.nvim"
        use "nvim-telescope/telescope-media-files.nvim"
        use "nvim-lua/popup.nvim"

        -- misc
        use "tweekmonster/startuptime.vim"
        use "907th/vim-auto-save"
        use "folke/zen-mode.nvim"
        use "karb94/neoscroll.nvim"

        -- additions
        -- note taking
        use "vimwiki/vimwiki"

        use "tpope/vim-fugitive"
        use "folke/which-key.nvim"
        use "glepnir/dashboard-nvim"
        --use "mattn/emmet-vim"
        use "folke/lsp-colors.nvim"
        use "prettier/vim-prettier"

        -- snippet support
        use "hrsh7th/vim-vsnip"
        use "hrsh7th/vim-vsnip-integ"
        use "rafamadriz/friendly-snippets"

        -- debugging
        use "puremourning/vimspector" --install file
        use "folke/lsp-trouble.nvim"
        use "michaelb/sniprun"
        use "folke/todo-comments.nvim"
        use 'kabouzeid/nvim-lspinstall'

    end
)
