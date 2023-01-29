-- INFO: https://github.com/ad-on-is/awesomewm-tokyo-darker/blob/main/rc.lua
--
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")
local menubar = require("menubar")
local beautiful = require("beautiful")
require("awful.autofocus")

local theme = "tokyonight-dark"
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/" .. theme .. "/theme.lua")
-- beautiful.useless_gap = 10
-- beautiful.gap_single_client = true

local terminal = "kitty"
awful.util.terminal = terminal
menubar.utils.terminal = terminal

-- CONFIG
require("config.bindings")
require("config.signals")
require("config.errors")
require("config.rules")
-- require("config.menu")
-- LAYOUT
require("layout")
