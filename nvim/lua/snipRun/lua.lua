require'sniprun'.setup({
  selected_interpreters = {"Lua_nvim"},     --" use those instead of the default for the current filetype
  repl_enable = {"Python3_original"},               --" enable REPL-like behavior for the given interpreters
  repl_disable = {},              --" disable REPL-like behavior for the given interpreters
  vim.g.sniprun.inline_messages = 0,             --" inline_message (0/1) is a one-line way to display messages
                                  --" to workaround sniprun not being able to display anything

  -- " you can combo different display modes as desired
  display = {
    -- "Classic",                    -- "display results in the command-line  area
    "VirtualTextOk",              -- "display ok results as virtual text (multiline is shortened)
    "VirtualTextErr",          -- "display error results as virtual text
    -- "TempFloatingWindow",      -- "display results in a floating window
    -- "LongTempFloatingWindow",  -- "same as above, but only long results. To use with VirtualText__
    -- "Terminal"                 -- "display results in a vertical split
    },

})
