#!/bin/bash

git clone https://github.com/siduck76/chad-nvim.git ~/tempDoots/
rsync -auvn ~/tempDoots/lua/ ~/.config/nvim/lua/ --exclude mappings/ --exclude pluginsList/ --exclude misc-utils/ --exclude lspconfig/
# post install clean-up
rm -rf ~/tempDoots

# folders that I updated
<<COMMENT
    treesitter
    lsp-config
    plugins
    dashboard (addition)
    mappings
    misc-utils
COMMENT
#
