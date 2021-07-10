local packer = require("packer")
local use = packer.use

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float {border = "single"}
        end
    },
    git = {
        clone_timeout = 600 -- Timeout, in seconds, for git clones
    }
}

return packer.startup(
    function()
        use "wbthomason/packer.nvim"

        use "akinsho/nvim-bufferline.lua"
        use "glepnir/galaxyline.nvim"

        -- color related stuff
        use "siduck76/nvim-base16.lua"

        use {
            "norcalli/nvim-colorizer.lua",
            event = "BufRead",
            config = function()
                require("colorizer").setup()
                vim.cmd("ColorizerReloadAllBuffers")
            end
        }

        -- language related plugins
        use {
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = function()
                require("treesitter-nvim").config()
            end
        }

        use {
            "neovim/nvim-lspconfig",
            event = "BufRead",
            config = function()
                require("nvim-lspconfig").config()
            end
        }
        use {
            "kabouzeid/nvim-lspinstall",
            event = "VimEnter"
        }

        use {
            "onsails/lspkind-nvim",
            event = "BufRead",
            config = function()
                require("lspkind").init()
            end
        }

        -- load compe in insert mode only
        use {
            "hrsh7th/nvim-compe",
            event = "InsertEnter",
            config = function()
                require("compe-completion").config()
            end,
            wants = {"LuaSnip"},
            requires = {
                {
                    "L3MON4D3/LuaSnip",
                    wants = "friendly-snippets",
                    event = "InsertCharPre",
                    config = function()
                        require("compe-completion").snippets()
                    end
                },
                "rafamadriz/friendly-snippets"
            }
        }

        use {"sbdchd/neoformat", cmd = "Neoformat"}

        -- file managing , picker etc
        use {
            "kyazdani42/nvim-tree.lua",
            cmd = "NvimTreeToggle",
            config = function()
                require("nvimTree").config()
            end
        }

        use "kyazdani42/nvim-web-devicons"
        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                {"nvim-lua/popup.nvim"},
                {"nvim-lua/plenary.nvim"},
                {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
                {"nvim-telescope/telescope-media-files.nvim"}
            },
            cmd = "Telescope",
            config = function()
                require("telescope-nvim").config()
            end
        }

        -- git stuff
        use {
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = function()
                require("gitsigns-nvim").config()
            end
        }

        -- misc plugins
        use {
            "windwp/nvim-autopairs",
            after = "nvim-compe",
            config = function()
                require("nvim-autopairs").setup()
                require("nvim-autopairs.completion.compe").setup(
                    {
                        map_cr = true,
                        map_complete = true -- insert () func completion
                    }
                )
            end
        }

        use {"andymass/vim-matchup", event = "CursorMoved"}

        use {
            "terrortylor/nvim-comment",
            cmd = "CommentToggle",
            config = function()
                require("nvim_comment").setup()
            end
        }

        use {
            "glepnir/dashboard-nvim",
            cmd = {
                "Dashboard",
                "DashboardNewFile",
                "DashboardJumpMarks",
                "SessionLoad",
                "SessionSave"
            },
            setup = function()
                require("dashboard").config()
            end
        }

        use {"tweekmonster/startuptime.vim", cmd = "StartupTime"}

        -- load autosave only if its globally enabled
        use {
            "Pocco81/AutoSave.nvim",
           config = function()
                require("zenmode").autoSave()
            end,
            cond = function()
                return vim.g.auto_save == true
            end
        }

        -- smooth scroll
        use {
            "karb94/neoscroll.nvim",
            event = "WinScrolled",
            config = function()
                require("neoscroll").setup()
            end
        }

        use {
            "Pocco81/TrueZen.nvim",
            cmd = {"TZAtaraxis", "TZMinimalist", "TZFocus"},
            config = function()
                require("zenmode").config()
            end
        }

        --   use "alvan/vim-closetag" -- for html autoclosing tag

        use {
            "lukas-reineke/indent-blankline.nvim",
            event = "BufRead",
            setup = function()
                require("misc-utils").blankline()
            end
        }
        --user added
        use {
            "folke/which-key.nvim",
            config = function()
                require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
              }
          end
        }
        use {
            "folke/todo-comments.nvim",
            requires = "nvim-lua/plenary.nvim",
            config = function()
                require("todo-comments").setup ({
                    keywords = {
                        FIX  = { icon = " ", color = "error" , alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }},
                        TODO = { icon = " ", color = "info" , alt = {"NOTE"}},
                        HACK = { icon = " ", color = "#EBCB8B" , alt = {"TEMP"}},
                        WARN = { icon = " ", color = "warning" , alt = { "WARNING", "DANGER" } },
                        PERF = { icon = " ", color = "default" , alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                        NOTE = { icon = " ", color = "hint" , alt = { "INFO" } },
                    },
                    colors = {
                        error = { "#BF616A" } ,
                        warning = { "#D08770"  },
                        info = { "#5E81AC" },
                        hint = { "#A3BE8C" },
                        default = { "#B48EAD" },
                    },
                })
            end
        }
        -- honestly <leader> fw and <C-q> is better
        -- use { --WARN: not working as well as telescope
        --     "folke/trouble.nvim",
        --     requires = "kyazdani42/nvim-web-devicons",
        --     config = function()
        --         require("trouble").setup {
        --       -- your configuration comes here
        --       -- or leave it empty to use the default settings
        --       -- refer to the configuration section below
        --     }
        --   end
        -- }
        use "tpope/vim-fugitive"
        use {
            'vimwiki/vimwiki',
            config = function()
                vim.g.vimwiki_global_ext = 0
                vim.g.vimwiki_list = {
                    {
                        auto_export =  1,
                        path_html = '~/Documents/dotFiles/obsidian/',
                        path = '~/Documents/dotFiles/obsidian/',
                        syntax = 'markdown',
                        ext = '.md',
                    }
                }
            end
        }
        use {'iamcco/markdown-preview.nvim', config = "vim.call('mkdp#util#install')"}
        use 'ggandor/lightspeed.nvim' --https://github.com/ggandor/lightspeed.nvim
        use "ray-x/lsp_signature.nvim"
        use {
          "numtostr/FTerm.nvim",
          config = function()
              require("FTerm").setup()
        end
        }
    end,
    {
        display = {
            border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"}
        }
    }
)
