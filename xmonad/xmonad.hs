{-|
Module : Main
Description : My XMonad config application
Copyright : (c) Henrick Deschamps, 2018
License : MIT
Maintainer: henrick.deschamps@gmail.com
Stability : experimental
-}
module Main
  ( main
  ) where

{------------------------------------------------------------------------------}
{-- Imports                                                                  --}
{------------------------------------------------------------------------------}
import           Data.Char                  (isHexDigit)
import           Data.Function
import qualified Data.Map                   as M
import           Data.Maybe
import           Data.Tuple
import           GHC.Word                   (Word8)
import           Numeric                    (readHex)
import           System.Exit
import           System.IO
import           Text.Printf                (printf)
import           XMonad
import           XMonad.Actions.CycleWS
import           XMonad.Config.Azerty
import           XMonad.Config.Desktop
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.SetWMName
import           XMonad.Layout
import           XMonad.Layout.Decoration
import           XMonad.Layout.Fullscreen
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Simplest
import           XMonad.Layout.Spacing
import           XMonad.Layout.Spiral
import           XMonad.Layout.Tabbed
import           XMonad.Layout.ThreeColumns
import qualified XMonad.StackSet            as W
import           XMonad.Util.EZConfig       (additionalKeys)
import           XMonad.Util.Run            (spawnPipe)

{- import           XMonad.Wallpaper -}

{------------------------------------------------------------------------------}


{------------------------------------------------------------------------------}
{-- My colors conf                                                           --}
{------------------------------------------------------------------------------}

-- | the 'MyColor' data
--
-- Takes and store red, green and blue primary colors.
--
data MyColor = MyColor
  { red   :: Word8
  , green :: Word8
  , blue  :: Word8
  }

-- | Black color constructor.
black :: MyColor
black = MyColor 0 0 0

-- | White color constructor.
white :: MyColor
white = MyColor 255 255 255

-- | Dark grey color constructor.
darkGrey :: MyColor
darkGrey = MyColor 42 42 42

-- | Medium grey color constructor.
mediumGrey :: MyColor
mediumGrey = MyColor 69 69 69

-- | Light grey color constructor.
lightGrey :: MyColor
lightGrey = MyColor 211 211 211

-- | Print the color in #RRGGBB format.
instance Show MyColor where
  show MyColor {red = r, green = g, blue = b} = printf "#%02X%02X%02X" r g b

-- | Read the color from a String in #RRGGBB format.
instance Read MyColor where
  readsPrec _ ('#':r1:r2:g1:g2:b1:b2:_) =
    [ ( uncurriedColor $
        map getPrimaryCol [r1 : r2 : "", g1 : g2 : "", b1 : b2 : ""]
      , "")
    | all isHexDigit [r1, r2, b1, b2, g1, g2]
    ]
  readsPrec _ _ = []

-- | Take a String containing a value for a color, and return this value in an octet.
getPrimaryCol :: String -> Word8
getPrimaryCol strPrimCol = fst $ head $ readHex strPrimCol

-- | Allows passing argument to Color constructror throught a list.
-- When ill formatted word list is given, returns black by default.
-- TODO(hnrck) improve error handling.
uncurriedColor :: [Word8] -> MyColor
uncurriedColor (r:g:b:_) = MyColor r g b
uncurriedColor _         = black

myNormalBorderColor, myFocusedBorderColor :: String
myNormalBorderColor = show darkGrey
myFocusedBorderColor = show lightGrey

-- Colors for text and backgrounds of each tab when in "Tabbed" layout.
tabConfig =
  defaultTheme
  { activeBorderColor = show darkGrey
  , activeTextColor = show white
  , activeColor = show darkGrey
  , inactiveBorderColor = show black
  , inactiveTextColor = show darkGrey
  , inactiveColor = show black
  }

-- Color of current window title in xmobar.
xmobarTitleColor :: String
xmobarTitleColor = show white

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor :: String
xmobarCurrentWorkspaceColor = show white

{------------------------------------------------------------------------------}


{------------------------------------------------------------------------------}
{-- My workspace conf                                                        --}
{------------------------------------------------------------------------------}

-- TODO(hnrck) Add some labels

myWorkspaces :: [WorkspaceId]
myWorkspaces =
  map show [1 .. 9 :: Int]

{------------------------------------------------------------------------------}


{------------------------------------------------------------------------------}
{-- My applications conf                                                     --}
{------------------------------------------------------------------------------}

-- TODO(hnrck) Add more applications.

-- Terminal.
myTerminal :: String
myTerminal = "sakura"

-- Lockscreen
myScreensaver :: String
myScreensaver = "lxlock"

-- Screenshots
myScreenshot :: String
myScreenshot = "gnome-screenshot"

myAreaScreenshot :: String
myAreaScreenshot = myScreenshot ++ " -a"

myWindowScreenshot :: String
myWindowScreenshot = myScreenshot ++ " -w"

-- The command to use as a launcher.
myLauncher :: String
myLauncher =
  "$(yeganesh -x -- -fn '-*-terminus-*-r-normal-*-*-120-*-*-*-*-iso8859-*' -nb '" ++
  show black ++
  "' -nf '" ++
  show white ++ "' -sb '" ++ show white ++ "' -sf '" ++ show black ++ "')"

{------------------------------------------------------------------------------}


{------------------------------------------------------------------------------}
{-- My manage hook conf                                                      --}
{------------------------------------------------------------------------------}

-- TODO(hnrck) more hooks
-- TODO(hnrck) better composition

myManageHook :: ManageHook
myManageHook =
  composeAll
    [ className =? "Chromium" --> doShift "2:web"
    , className =? "Google-chrome" --> doShift "2:web"
    , className =? "Firefox" --> doShift "2:web"
    , resource =? "desktop_window" --> doIgnore
    , className =? "Steam" --> doFloat
    , className =? "Gimp" --> doFloat
    , className =? "stalonetray" --> doIgnore
    , className =? "Thunderbird" --> doShift "9:mail"
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)
    ]

{------------------------------------------------------------------------------}


{------------------------------------------------------------------------------}
{-- My borders conf                                                          --}
{------------------------------------------------------------------------------}

-- | myBorderWidth function, return the width of windows borders.
myBorderWidth :: Dimension
myBorderWidth = 1

-- | mySpacingSize function, return the size of space between space windows.
mySpacingSize :: Dimension
mySpacingSize = 3

{------------------------------------------------------------------------------}


{------------------------------------------------------------------------------}
{-- My layout conf                                                           --}
{------------------------------------------------------------------------------}

-- | Tall layout
myTallLayout = Tall 1 (3 / 100) (1 / 2)

-- | Mirror layout
myMirrorTallLayout = Mirror myTallLayout

-- | Three columns layout
myThreeColMidLayout = ThreeColMid 1 (3 / 100) (1 / 2)

-- | Tabbed layout
myTabbedLayout = tabbed shrinkText tabConfig

-- | Fullscreen layout
myFullLayout = Full

-- | Spiral layout
mySpiralLayout = spiral (6 / 7)

-- | My layout, containing all previously cited layout
myLayout =
  smartSpacing (fromIntegral mySpacingSize) $
  smartBorders $
  avoidStruts
    (avoidStruts
       (myTallLayout |||
        myMirrorTallLayout |||
        myThreeColMidLayout |||
        myTabbedLayout ||| myFullLayout ||| mySpiralLayout) |||
     noBorders (fullscreenFull Full))

{------------------------------------------------------------------------------}


{------------------------------------------------------------------------------}
{-- My wallpapers conf                                                       --}
{------------------------------------------------------------------------------}

-- wallpaperDirs :: [FilePath]
-- wallpaperDirs = ["$HOME/.wallpaper"]

{------------------------------------------------------------------------------}


{------------------------------------------------------------------------------}
{-- My key bindings conf                                                     --}
{------------------------------------------------------------------------------}

-- | Default key for XMonad: SUPER_L.
myModMask :: KeyMask
myModMask = mod4Mask

-- | XMonad keybinding.
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@XConfig {XMonad.modMask = modM} =
  M.fromList $
    -- Alphanumeric keys
    -- Numeric keys
  [ ((m .|. modM, k), windows $ f i)
  | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9] -- Switch to workspace
  , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)] -- Send focused window to workspace
  ] ++
  [
    -- First row
    -- a
    ((modM, xK_a), screenWorkspace 0 >>= flip whenJust (windows . W.view)) -- Go to first screen
    -- z
  , ((modM, xK_z), screenWorkspace 1 >>= flip whenJust (windows . W.view)) -- Go to second screen
    -- e
    -- r
    -- t
  , ((modM, xK_t), withFocused $ windows . W.sink) -- Change floating window into tiling one
    -- y
    -- u
    -- i
    -- o
    -- p
  , ((modM, xK_p), spawn myLauncher) -- Launcher
  , ((modM .|. shiftMask, xK_p), spawn myAreaScreenshot) -- Screenshot
  , ((modM .|. controlMask .|. shiftMask, xK_p), spawn myScreenshot) -- Area screenshot
    -- Second row
    -- q
  , ((modM, xK_q), restart "xmonad" True) -- Restart xmonad
  , ((modM .|. shiftMask, xK_q), io exitSuccess) -- Quit xmonad.
    -- s
    -- d
    -- f
    -- g
    -- h
  , ((modM, xK_h), sendMessage Shrink) -- Shrink the master area
    -- j
  , ((modM, xK_j), windows W.focusDown) -- Focus on next window
  , ((modM .|. shiftMask, xK_j), windows W.swapDown) -- Swap the focused window with the next window
  , ((modM .|. controlMask, xK_j), spawn "amixer -q set Master 10%-") -- Decrease volume
    -- k
  , ((modM, xK_k), windows W.focusUp) -- Focus on previous window
  , ((modM .|. shiftMask, xK_k), windows W.swapUp) -- Swap the focused window with the previous window
  , ((modM .|. controlMask, xK_k), spawn "amixer -q set Master 10%+") -- Increase volume
    -- l
  , ((modM, xK_l), sendMessage Expand) -- Expand the master area
  , ((modM .|. controlMask, xK_l), spawn myScreensaver) -- Start screensaver
    -- m
  , ((modM, xK_m), windows W.focusMaster) -- Focus on master window
  , ((modM .|. controlMask, xK_m), spawn "amixer -q set Master toggle") -- Mute / Unmute volume
    -- Third row
    -- w
    -- x
    -- c
  , ((modM .|. shiftMask, xK_c), kill) -- Close window
    -- v
    -- b
    -- n
    -- , ?
  , ((modM, xK_comma), sendMessage (IncMasterN 1)) -- Increment the number of windows in the master area
    -- ; .
  , ((modM, xK_period), sendMessage (IncMasterN (-1))) -- Decrement the number of windows in the master area
    -- : /
    -- ! §
    -- * µ
  ] ++
    -- Special keys
    -- Return
  [ ((modM, xK_Return), spawn $ XMonad.terminal conf) -- Terminal
  , ((modM .|. shiftMask, xK_Return), windows W.swapMaster) -- Swap focus between the current window and the master window
    -- Space
  , ((modM, xK_space), sendMessage NextLayout) -- Next layout
  , ((modM .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf) -- First layout
  ] ++
    -- Arrows
  [((modM, xK_Left), prevWS), ((modM, xK_Right), nextWS)]

-- | My azerty keys function, takes default keys, and map them to azerty keys
myAzertyKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myAzertyKeys k = azertyKeys k `M.union` myKeys k

{------------------------------------------------------------------------------}


{------------------------------------------------------------------------------}
{-- My mouse bindings conf                                                   --}
{------------------------------------------------------------------------------}

-- Focus rules
-- True if your focus should follow your mouse cursor.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myMouseBindings :: XConfig Layout -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings XConfig {XMonad.modMask = modM} =
  M.fromList
      -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modM, button1), \w -> focus w >> mouseMoveWindow w)
      -- mod-button2, Raise the window to the top of the stack
    , ((modM, button2), \w -> focus w >> windows W.swapMaster)
      -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modM, button3), \w -> focus w >> mouseResizeWindow w)
    ]

{------------------------------------------------------------------------------}


{------------------------------------------------------------------------------}
{-- My start-up hook conf                                                    --}
{------------------------------------------------------------------------------}

myStartupHook :: X ()
myStartupHook = return ()

mainStartupHook :: X ()
mainStartupHook = setWMName "LG3D"

{------------------------------------------------------------------------------}


{------------------------------------------------------------------------------}
{-- My xmobar conf                                                           --}
{------------------------------------------------------------------------------}

myXmobarExe :: String
myXmobarExe = "xmobar"

myXmobarPath :: FilePath
myXmobarPath = "~/.xmonad/"

myXmobarFile :: FilePath
myXmobarFile = myXmobarPath ++ "xmobar.hs"

xmobarSpawn :: MonadIO m => m Handle
xmobarSpawn = spawnPipe $ unwords [myXmobarExe, myXmobarFile]

{------------------------------------------------------------------------------}


{------------------------------------------------------------------------------}
{-- My conf                                                                  --}
{------------------------------------------------------------------------------}

-- | My configuration function
myConfig =
  -- def -- With recent XMonad
  defaultConfig -- With old XMonad
  { terminal = myTerminal
  , focusFollowsMouse = myFocusFollowsMouse
  , borderWidth = myBorderWidth
  , modMask = myModMask
  , workspaces = myWorkspaces
  , normalBorderColor = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor
  , keys = myAzertyKeys -- /!\ I use an AZERTY keyboard
  , mouseBindings = myMouseBindings
  , layoutHook = myLayout
  , manageHook = myManageHook
  , startupHook = myStartupHook
  }

{------------------------------------------------------------------------------}


{------------------------------------------------------------------------------}
{-- Main                                                                     --}
{------------------------------------------------------------------------------}

-- Run xmonad with all the defaults we set up.
main :: IO ()
main = do
  xmproc <- xmobarSpawn -- Spawning Xmobar
  xmonad $ 
    myConfig -- Starting XMonad with my config
    { logHook =
        dynamicLogWithPP $
        xmobarPP
        { ppOutput = hPutStrLn xmproc
        , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
        , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
        , ppSep = "   "
        }
    , manageHook = manageDocks <+> manageHook myConfig
    , startupHook = startupHook myConfig
    }
{------------------------------------------------------------------------------}
