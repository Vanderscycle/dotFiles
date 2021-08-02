local present, _ = pcall(require, "packerInit")
local packer

if present then
    packer = require "packer"
else
    return false
end

local use = packer.use

return packer.startup(
    function()
        use {
            "wbthomason/packer.nvim",
            event = "VimEnter"
        }

        use {
            "jdhao/better-escape.vim",
            event = "InsertEnter",
            config = function()
                require "plugins.others".escape()
            end
        }

        use {
            "akinsho/nvim-bufferline.lua",
            after = "nvim-base16.lua",
            config = function()
                require "plugins.bufferline"
            end
        }

        use {
            "glepnir/galaxyline.nvim",
            after = "nvim-base16.lua",
            config = function()
                require "plugins.statusline"
            end
        }

        -- color related stuff
        use {
            "siduck76/nvim-base16.lua",
            after = "packer.nvim",
            config = function()
                require "theme"
            end
        }

        use {
            "norcalli/nvim-colorizer.lua",
            event = "BufRead",
            config = function()
                require("plugins.others").colorizer()
            end
        }

        -- language related plugins
        use {
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = function()
                require "plugins.treesitter"
            end
        }

        use {
            "kabouzeid/nvim-lspinstall",
            event = "BufRead"
        }

        use {
            "neovim/nvim-lspconfig",
            after = "nvim-lspinstall",
            config = function()
                require "plugins.lspconfig"
            end
        }

        use {
            "onsails/lspkind-nvim",
            event = "BufRead",
            config = function()
                require("plugins.others").lspkind()
            end
        }

        -- load compe in insert mode only
        use {
            "hrsh7th/nvim-compe",
            event = "InsertEnter",
            config = function()
                require "plugins.compe"
            end,
            wants = "LuaSnip",
            requires = {
                {
                    "L3MON4D3/LuaSnip",
                    wants = "friendly-snippets",
                    event = "InsertCharPre",
                    config = function()
                        require "plugins.luasnip"
                    end
                },
                {
                    "rafamadriz/friendly-snippets",
                    event = "InsertCharPre"
                }
            }
        }

        use { --TODO: add the relevant npm -g packages https://github.com/sbdchd/neoformat
            "sbdchd/neoformat",
            cmd = "Neoformat"
        }

        -- file managing , picker etc
        use {
            "kyazdani42/nvim-tree.lua",
            cmd = "NvimTreeToggle",
            config = function()
                require "plugins.nvimtree"
            end
        }

        use {
            "kyazdani42/nvim-web-devicons",
            after = "nvim-base16.lua",
            config = function()
                require "plugins.icons"
            end
        }

        use {
            "nvim-lua/plenary.nvim",
            event = "BufRead"
        }
        use {
            "nvim-lua/popup.nvim",
            after = "plenary.nvim"
        }

        use {
            "nvim-telescope/telescope.nvim",
            cmd = "Telescope",
            config = function()
                require "plugins.telescope"
            end
        }

        use {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
            cmd = "Telescope"
        }
        use {
            "nvim-telescope/telescope-media-files.nvim",
            cmd = "Telescope"
        }
        use {
            "nvim-telescope/telescope-dap.nvim",
            cmd = "Telescope"
        }
        -- git stuff
        use {
            "lewis6991/gitsigns.nvim",
            after = "plenary.nvim",
            config = function()
                require "plugins.gitsigns"
            end
        }

        -- misc plugins
        use {
            "windwp/nvim-autopairs",
            after = "nvim-compe",
            config = function()
                require "plugins.autopairs"
            end
        }

        use { --TODO: read https://github.com/andymass/vim-matchup
            "andymass/vim-matchup",
            event = "CursorMoved"
        }

        use {
            "terrortylor/nvim-comment",
            cmd = "CommentToggle",
            config = function()
                require("plugins.others").comment()
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
                require "plugins.dashboard"
            end
        }

        use {
            "dstein64/vim-startuptime",
            cmd = "StartupTime"
        }

        -- load autosave only  its globally enabled
        use {
            "Pocco81/AutoSave.nvim",
            config = function()
                require "plugins.autosave"
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
                require("plugins.others").neoscroll()
            end
        }

        use {
            "Pocco81/TrueZen.nvim",
            cmd = {
                "TZAtaraxis",
                "TZMinimalist",
                "TZFocus"
            },
            config = function()
                require "plugins.zenmode"
            end
        }

        --   use "alvan/vim-closetag" -- for html autoclosing tag

        use {
            "lukas-reineke/indent-blankline.nvim",
            event = "BufRead",
            setup = function()
                require("plugins.others").blankline()
            end
        }

        use {
            "tpope/vim-fugitive",
            cmd = {
                "Git","G"
            }
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
        use {
            'glepnir/lspsaga.nvim',
            branch = 'main',
            requires = {
                'neovim/nvim-lspconfig',
            },
          config = function()
              require "plugins.lspsaga_config"
        end
        }
        -- floating terminal
        use {
          "numtostr/FTerm.nvim",
          config = function()
              require("FTerm").setup()
        end
        }
        use {
            'vimwiki/vimwiki',
            cmd = "VimwikiIndex",
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
        use { --WARN: need to integrate
              --TODO: make it lazy load
              -- TODO: add bindings
            'mfussenegger/nvim-dap'
        }
        use { --TODO: figure out how to integrate better
            "sindrets/diffview.nvim",
            module = "diffview",
            cmd = "DiffviewOpen"
        }
        --todo add gelguy/wilder.nvim

    end
)
