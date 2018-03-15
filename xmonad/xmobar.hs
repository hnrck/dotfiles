Config {
      font = "xft:Inconsolata Nerd Font Mono Medium:size=9:antialias=true"
    , additionalFonts = ["xft:FontAwesome:size=9:antialias=true" ]
    , bgColor = "#000000"
    , fgColor = "#ffffff"
    , borderColor = "#000000"

    -- Colors alt -- solarized dark: 
    -- , bgColor = "#002b36"
    -- , fgColor = "#93a1a1"
    -- , borderColor = "#002b36"
    --
    -- Colors alt -- solarized light:
    -- , bgColor = "#fdf6e3"
    -- , fgColor = "#586e75"
    -- , borderColor = "#fdf6e3"

    , iconRoot = "."
    , iconOffset = -1
    , position = Top
    , border = BottomB
    , textOffset = -1
    , allDesktops = True
    , sepChar = "%"
    , alignSep = "}{"
    , template = "<fn=1></fn> %StdinReader% }{ <fn=1></fn> %multicpu% | <fn=1></fn> %memory% | <fn=1></fn> %coretemp% | <fn=1></fn> %swap% | %battery% | %date% "
    , lowerOnStart = False
    , hideOnStart = False
    , overrideRedirect = True
    , pickBroadest = True
    , persistent = True
    , commands = [
          Run MultiCpu       [ "-t"         , "Cpu:<total0> <total1> <total2> <total3> <total4> <total5> <total6> <total7>" 
                             , "-L"         , "20"
                             , "-H"         , "50"
                             , "-h"         , "#dc322f"
                             , "-n"         , "#cb4b16"
                             , "-l"         , "#859900"
                             , "-w"         , "3"
                             ] 10
        , Run Memory         [ "-t"         , "Mem: <usedratio>%"
                             , "-H"         , "8192"
                             , "-L"         , "4096"
                             , "-h"         , "#dc322f"
                             , "-n"         , "#cb4b16"
                             , "-l"         , "#859900"
                             ] 10
        , Run Swap           [ "-t"         , "Swap: <usedratio>%"
                             , "-H"         , "1024"
                             , "-L"         , "512"
                             , "-h"         , "#dc322f"
                             , "-n"         , "#cb4b16"
                             , "-l"         , "#859900"
                             ] 10
        , Run Date           "<fn=1></fn> %a, %B %_d | <fn=1></fn> %H:%M" "date" 10
        , Run CoreTemp       [ "--template" , "Temp: <core0>°C <core1>°C <core2>°C <core3>°C"
                             , "--Low"      , "60"
                             , "--High"     , "80"
                             , "--high"     , "#dc322f"
                             , "--normal"   , "#cb4b16"
                             , "--low"      , "#859900"
                             ] 50
        , Run Battery        [ "--template" , "<fn=1></fn> Batt: <acstatus>"
                             , "--Low"      , "10"
                             , "--High"     , "80"
                             , "--high"     , "#859900"
                             , "--normal"   , "#cb4b16"
                             , "--low"      , "#dc322f"
                             , "--"
                             , "-o"   , "<left>% (<timeleft>)"
                             , "-O" , "<fc=#cb4b16>Charging</fc>"
                             , "-i"   , "<fc=#859900>Charged</fc>"
                             ] 50
        , Run StdinReader
    ]
}
