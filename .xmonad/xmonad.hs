--INFO: keybindings
-- super + j/k focus amongst windows
-- super + shift + j/k focus swap neighboring windows
-- super + space re-arrange windows (default 3)
-- super + h/l make current window smaller/larger

-- super + shift + c close a window
-- super + shift + t opens a terminal\

-- super + # switches workspace
-- super + shift + # moves the window to the # workspace
-- super + q refresh config file
-- super + p command palette
-- IMPORTS

import Data.Default
import qualified Data.Map as M
import qualified XMonad.StackSet as W

import Data.Maybe (fromJust)
import Data.Monoid
import Data.Word
import Data.List (sortBy)

import Graphics.X11.Xlib
import Graphics.X11.Xlib.Extras
import System.Exit

import XMonad
import XMonad.Hooks.DynamicLog (PP (..), dynamicLogWithPP, shorten, wrap, xmobarColor, xmobarPP)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

-- import XMonad.EZConfig (additionalKeysP) -- https://lambdablob.com/posts/xmonad-ez-keyboard-shortcuts/

import XMonad.Layout.Fullscreen
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.Gaps
import XMonad.Layout.ThreeColumns
import XMonad.Layout.NoBorders

import XMonad.Actions.SpawnOn

import XMonad.Util.NamedWindows (getName)
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
-- import for media keys
import Graphics.X11.ExtraTypes.XF86
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.

import Control.Monad (join)

myTerminal = "kitty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Width of the window border in pixels.
--
myBorderWidth = 2
myGaps              = [(U, 30), (D, 10), (L, 10), (R, 10)]
mySpacing           = 3

myModMask = mod4Mask -- super
modm2 = myModMask .|. controlMask
myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]
-- myWorkspaces = [" dev ", " www ", " sys ", " doc ", " vbox ", " chat ", " mus ", " vid ", " gfx "]

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1 ..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+" ++ show i ++ ">" ++ ws ++ "</action>"
  where
    i = fromJust $ M.lookup ws myWorkspaceIndices

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor = "#24283b"
myFocusedBorderColor = "#74BBFB"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
-- INFO:https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Util-EZConfig.html
-- ctrlMask = controlMask
--
myKeys conf@(XConfig {XMonad.modMask = modm}) =
  M.fromList $
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf),
      -- launch dmenu
      ((modm, xK_p), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\""),
      -- launch gmrun
      ((modm .|. shiftMask, xK_p), spawn "rofi -show run"),
    -- Run xmessage with a summary of the default keybindings (useful for beginners)
      ((modm, xK_equal ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -")),
      -- dedicated nnn finder with tmux preview window
      ((modm, xK_f), spawn "kitty -e nnn -H"),
      -- close focused window
      ((modm .|. shiftMask, xK_c), kill),
      -- Rotate through the available layout algorithms
      ((modm, xK_space), sendMessage NextLayout),
      --  Reset the layouts on the current workspace to default
      ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf),
      -- Resize viewed windows to the correct size
      ((modm, xK_n), refresh),
      -- Move focus to the next window
      ((modm, xK_Tab), windows W.focusDown),
      -- Move focus to the next window
      ((modm, xK_j), windows W.focusDown),
      -- Move focus to the previous window
      ((modm, xK_k), windows W.focusUp),
      -- Move focus to the master window
      ((modm, xK_m), windows W.focusMaster),
      -- Swap the focused window and the master window
      ((modm, xK_Return), windows W.swapMaster),
      -- Swap the focused window with the next window
      ((modm .|. shiftMask, xK_j), windows W.swapDown),
      -- Swap the focused window with the previous window
      ((modm .|. shiftMask, xK_k), windows W.swapUp),
      -- Shrink the master area
      ((modm, xK_h), sendMessage Shrink),
      -- Expand the master area
      ((modm, xK_l), sendMessage Expand),
      -- Push window back into tiling
      ((modm, xK_t), withFocused $ windows . W.sink),
      -- Increment the number of windows in the master area
      ((modm, xK_comma), sendMessage (IncMasterN 1)),
      -- Deincrement the number of windows in the master area
      ((modm, xK_period), sendMessage (IncMasterN (-1))),
      -- media keys
      ((0, xF86XK_AudioLowerVolume   ), spawn "pactl set-sink-volume 0 -1.5%"),
      ((0, xF86XK_AudioRaiseVolume   ), spawn "pactl set-sink-volume 0 +1.5%"),
      ((0, xF86XK_AudioPlay          ), spawn "playerctl play-pause"),
      ((0, xF86XK_AudioMute          ), spawn "pactl set-sink-mute 0 toggle"),
      ((0, xF86XK_AudioNext          ), spawn "playerctl next"),
      ((0, xF86XK_AudioPrev          ), spawn "playerctl previous"),
      -- Toggle the status bar gap
      -- Use this binding with avoidStruts from Hooks.ManageDocks.
      -- See also the statusBar function from Hooks.DynamicLog.
      --
      -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

  -- Quit xmonad
      ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess)),
      -- Restart xmonad
      ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart"),
      -- printscreen
      ((modm .|. shiftMask, xK_s), spawn "maim -s ~/Pictures/$(date +%s).png"),
      ((modm .|. shiftMask, xK_x), spawn "maim -s | xclip -selection clipboard -t image/png"),
      ((modm .|. controlMask .|. shiftMask, xK_p), spawn "picom --experimental-backends -b  &"),
      ((modm .|. controlMask .|. shiftMask, xK_k), spawn "killall picom"),
-- "picom --experimental-backends -b  &"
      ((modm, xK_Escape), spawn "$HOME/Documents/dotFiles/postInstallScripts/keebsLayout.sh")
    ]
      ++
      --
      -- mod-[1..9], Switch to workspace N
      --
      -- mod-[1..9], Switch to workspace N
      -- mod-shift-[1..9], Move client to workspace N
      --
      [ ((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9],
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
      ]
      ++
      --
      -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
      -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
      --
      [ ((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0 ..],
          (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
      ]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--

myMouseBindings (XConfig {XMonad.modMask = modm}) =
  M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ( (modm, button1),
        ( \w ->
            focus w >> mouseMoveWindow w
              >> windows W.shiftMaster
        )
      ),
      -- mod-button2, Raise the window to the top of the stack
      ((modm, button2), (\w -> focus w >> windows W.shiftMaster)),
      -- mod-button3, Set the window to floating mode and resize by dragging
      ( (modm, button3),
        ( \w ->
            focus w >> mouseResizeWindow w
              >> windows W.shiftMaster
        )
      )
      -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:
threeLayout = ThreeCol 2 (3/100) (1/2)
myLayout = avoidStruts (smartBorders (threeLayout ||| tiled ||| Mirror tiled ||| Full ||| spiral (6/7) 
               ))
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled = Tall nmaster delta ratio
    -- The default number of windows in the master pane
    nmaster = 1
    -- Default proportion of screen occupied by master pane
    ratio = 1 / 2
    -- Percent of screen to increment by when resizing panes
    delta = 3 / 100

------------------------------------------------------------------------
-- Window rules:

myManageHook =
  composeAll
    [ className =? "MPlayer" --> doFloat,
      className =? "Gimp" --> doFloat,
      className =? "gmrun" --> doFloat,
       className =? "Steam"          --> doFloat,
      className =? "steam" --> doFullFloat,
      resource =? "desktop_window" --> doIgnore,
      resource =? "kdesktop" --> doIgnore
    ]

------------------------------------------------------------------------
-- Transparency

setTransparentHook :: Event -> X All
setTransparentHook ConfigureEvent {ev_event_type = createNotify, ev_window = id} = do
  setOpacity id opacity
  return (All True)
  where
    opacityFloat = 0.9
    opacity = floor $ fromIntegral (maxBound :: Word32) * opacityFloat
    setOpacity id op = spawn $ "xprop -id " ++ show id ++ " -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY " ++ show op
setTransparentHook _ = return (All True)

------------------------------------------------------------------------
-- Event handling

-- myEventHook =  ewmhDesktopsEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- myLogHook = return()
myLogHook h = dynamicLogWithPP $ def
  { ppLayout = wrap "(<fc=#e0af68>" "</fc>)"
  -- , ppSort = getSortByXineramaRule  -- Sort left/right screens on the left, non-empty workspaces after those
  , ppTitleSanitize = const ""  -- Also about window's title
  , ppVisible = wrap "(" ")"  -- Non-focused (but still visible) screen
  , ppCurrent = wrap "<fc=#f7768e>[</fc><fc=#73daca>" "</fc><fc=#f7768e>]</fc>"-- Non-focused (but still visible) screen
  , ppOutput = hPutStrLn h
  }

----------------------------------------------------------------------
-- Startup hook

myStartupHook = do
  spawnOnce "nitrogen --restore &"
  spawnOnce "picom -b &"
  -- spawnOnOnce "3" "spotify &" --spawnOnOnce :: WorkspaceId -> String -> X ()Source -- https://hackage.haskell.org/package/xmonad-contrib-0.14/docs/XMonad-Util-SpawnOnce.html
  spawnOnOnce "2" "firefox&"
  spawnOnOnce "3" "discord &"
  -- spawnOnOnce "2" "slack &"
  spawnOnce "kitty &"
  spawnOnce "fcitx -d &"
  spawnOnce "xmobar &"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

main = do
  xmproc <- spawnPipe "xmobar -x 0 ~/.config/xmobar/xmobarrc"
  xmonad . ewmhFullscreen . ewmh $
    docks $  def
    { -- simple stuff
      terminal = myTerminal,
      focusFollowsMouse = myFocusFollowsMouse,
      borderWidth = myBorderWidth,
      modMask = myModMask,
      -- numlockMask deprecated in 0.9.1
      -- numlockMask        = myNumlockMask,
      workspaces = myWorkspaces,
      normalBorderColor = myNormalBorderColor,
      focusedBorderColor = myFocusedBorderColor,

      -- key bindings
      keys = myKeys,
      mouseBindings = myMouseBindings,

      -- hooks, layouts
      layoutHook = spacingWithEdge 10 $ myLayout,
      manageHook = myManageHook,
      -- handleEventHook = myEventHook,
      startupHook = myStartupHook,
      logHook = myLogHook xmproc
    }




-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch kitty term",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-Shift-{1..9}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]

