local M = {}

M.config = function()
    local g = vim.g

    g.dashboard_disable_at_vimenter = 0 -- dashboard is disabled by default
    g.dashboard_disable_statusline = 1
    g.dashboard_default_executive = "telescope"
    g.dashboard_custom_header = {
          "",
          "=================     ===============     ===============   ========  ========",
          "\\\\ . . . . . . .\\\\   //. . . . . . .\\\\   //. . . . . . .\\\\  \\\\. . .\\\\// . . //",
          "||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\\/ . . .||",
          "|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||",
          "||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||",
          "|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\\ . . . . ||",
          "||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. .||",
          "|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\\ `-_/| . ||",
          "||_-' ||  .|/    || ||    \\|.  || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_.||",
          "||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  `||",
          "||    `'         || ||         `'    || ||    `'         || ||   | \\  / |   ||",
          "||            .===' `===.         .==='.`===.         .===' /==. |  \\/  |   ||",
          "||         .=='   \\_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \\/  |   ||",
          "||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \\/  |   ||",
          "||   .=='    _-'          '-__\\._-'         '-_./__-'         `' |. /|  |   ||",
          "||.=='    _-'                                                     `' |  /==.||",
          "=='    _-'                          N V I M                           \\/   `==",
          "\\   _-'                                                                `-_   /",
          " `''                                                                      ``'",
          ""
 }

    g.dashboard_custom_section = {
        a = {description = {'  Find File             leader + f f'}, command = 'Telescope find_files'},
        b = {description = {'  Recently Used Files   leader + f o'}, command = 'Telescope oldfiles'},
        c = {description = {'  Directory Search      leader + f t'}, command = 'Telescope file_browser'},
        d = {description = {'  Find Word             leader + f s'}, command = 'Telescope live_grep'},
        e = {description = {'  init.lua              leader + c i'}, command = ':e ~/.config/nvim/init.lua'},
        f = {description = {'H  Colors                leader + c h'}, command = ':e ~/.config/nvim/lua/highlights/lua.lua'},
        f = {description = {'M  Mapping               leader + c m'}, command = ':e ~/.config/nvim/lua/mappings/lua.lua'},
    }


    g.dashboard_custom_footer = {
        "   ",
        "Henri Vandersleyen"
    }
end

return M
