--------------------------------------------------------------------
  -- File Name: xmonad.hs
  -- Purpose: Configure the Xmonad tiled window manager
  -- Creation Date: Sat Jul 07 07:13:31 CDT 2016
  -- Last Modified: Sun Jan 22 17:21:02 CST 2017
  -- Created By: Ivan Guerra <Ivan.E.Guerra-1@ou.edu>
--------------------------------------------------------------------
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import Graphics.X11.ExtraTypes.XF86 (xF86XK_AudioLowerVolume, xF86XK_AudioRaiseVolume, xF86XK_AudioMute, xF86XK_MonBrightnessDown, xF86XK_MonBrightnessUp)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.CycleWS
import XMonad.Layout.BorderResize
import System.IO

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , handleEventHook    = handleEventHook defaultConfig <+> docksEventHook
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#bdbdbd" "" . shorten 50
                        }
        , modMask = mod4Mask                                                     -- Rebind Mod to the Windows key
        , terminal = "xfce4-terminal"                                            -- Set the default terminal to the Xfce terminal
        , normalBorderColor = "black"
        , focusedBorderColor = "#bdbdbd"
        , startupHook = setWMName "LG3D" <+> spawn "compton --backend glx -fcC"
        } `additionalKeys`
        [   ((mod4Mask .|. controlMask, xK_l), spawn "slock")                    -- Call slock to lock the screen
          , ((mod4Mask .|. controlMask, xK_b), spawn "chromium")                 -- Launch a Chromium browser instance
          , ((mod4Mask .|. controlMask, xK_g), spawn "emacs")                    -- Launch an Emacs instance
          , ((mod4Mask,               xK_Right),  nextWS)                        -- Map Mod and right key to move to next workspace
          , ((mod4Mask,               xK_Left),  prevWS)                         -- Map Mod and left key to move to previous workspace
          , ((0                     , xF86XK_AudioLowerVolume), spawn "amixer set Master 4-") -- use the function keys to decrease the volume
          , ((0                     , xF86XK_AudioRaiseVolume), spawn "amixer set Master 4+") -- use the function keys to increase the volume
          , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -10")              -- use the function keys to decrease screen brightness
          , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight +10")                -- use the function keys to increase screen brightness
          , ((mod4Mask .|. controlMask, xK_F4), spawn "sudo shutdown -h now")    -- shutdown the machine
          , ((mod4Mask .|. controlMask, xK_F5), spawn "sudo shutdown -r now")    -- restart the machine
        ]
