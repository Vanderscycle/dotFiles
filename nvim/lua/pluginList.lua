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
        use {
            "glepnir/galaxyline.nvim",
            after = "nvim-base16.lua",
            config = function()
                require "statusline"
            end
        }

        -- color related stuff
        use {
            "norcalli/nvim-base16.lua",
            --after = "packer.nvim",
            --config = function()
            --    require "theme"
            --end
        }
        use {
         "akinsho/nvim-bufferline.lua",
          --after = "nvim-base16.lua",
            config = function()
                require "bufferline"
            end
        }

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
            --event = "BufRead",
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
        use "kabouzeid/nvim-lspinstall"

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
                {"nvim-telescope/telescope-media-files.nvim"},
                {"nvim-telescope/telescope-dap.nvim"}
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

        use {
          "dstein64/vim-startuptime",
          cmd = "StartupTime"
        }

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
            cmd = {
                "TZAtaraxis",
                "TZMinimalist",
                "TZFocus"
            },
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

        use { --TODO: make it lazy loading
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
        use {
            'iamcco/markdown-preview.nvim',
            cmd = "VimwikiIndex",
            config = "vim.call('mkdp#util#install')"
        }
        use 'ggandor/lightspeed.nvim' --https://github.com/ggandor/lightspeed.nvim

        -- lsp config additions (needs lazy loading)
        -- TODO: add https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils
        -- WARN: does it even work?
        -- TODO: disable it and see what happens
        use {
          'jose-elias-alvarez/nvim-lsp-ts-utils',
          disable=false,
          requires = {
              'neovim/nvim-lspconfig',
              "nvim-lua/plenary.nvim",
          }
        }
        use {
          "ray-x/lsp_signature.nvim",
          disable = true,
          config = function()
              require"lsp_signature".on_attach()
          end,
          event = "BufRead",
          requires = {
              'neovim/nvim-lspconfig'
            }
        }
        use {
            'glepnir/lspsaga.nvim',
            branch = 'main',
            requires = {
                'neovim/nvim-lspconfig',
                "ray-x/lsp_signature.nvim"
            }
        }
        --debugging
        -- WARN: both need work to integrate
        use { --WARN: need to integrate
            'mfussenegger/nvim-dap'
        }
        use { --WARN: mapping required https://github.com/David-Kunz/jester
            'David-Kunz/jester'
        }
        -- floating terminal
        use {
          "numtostr/FTerm.nvim",
          config = function()
              require("FTerm").setup()
        end
        }
        -- git
        use {
            "tpope/vim-fugitive",
            cmd = {
                "G",
                "Git"
              }
          }
        use {
            "sindrets/diffview.nvim",
            module = "diffview",
            cmd = "DiffviewOpen"
        }
        use {
            'pwntester/octo.nvim',
            config=function()
                require"octo".setup()
            end,
            cmd = "Telescope", 
            requires = {
                "nvim-telescope/telescope.nvim"
            },
            -- wants = {
            --     'nvim-telescope'
            -- }
        }
        -- comments
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
            'JoosepAlviste/nvim-ts-context-commentstring',--BUG: issues with svelte
            --opt = true,
            --run = ":TSUpdate", --needs to load manually
            wants = 'nvim-treesitter'
            }
        use {--INFO: toggle comments <leader>+/
            "terrortylor/nvim-comment",
            cmd = "CommentToggle",
            config = function()
                require("nvim_comment").setup()
                require('ts_context_commentstring.internal').update_commentstring() --not working
            end
        }
        use {
          'abecodes/tabout.nvim',
          config = function()
            require('tabout').setup {
            tabkey = '<Tab>', -- key to trigger tabout
            backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout
            act_as_tab = true, -- shift content if tab out is not possible
            act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
            enable_backwards = true, -- well ...
            completion = true, -- if the tabkey is used in a completion pum
            tabouts = {
              {open = "'", close = "'"},
              {open = '"', close = '"'},
              {open = '`', close = '`'},
              {open = '(', close = ')'},
              {open = '[', close = ']'},
              {open = '{', close = '}'}
            },
            ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
            exclude = {} -- tabout will ignore these filetypes
        }
          end,
                wants = {'nvim-treesitter'}, -- or require if not used so far
                after = {'nvim-compe'} -- if a completion plugin is using tabs load it before
        }
    end,
    {
        display = {
            border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"}
        }
    }
)
