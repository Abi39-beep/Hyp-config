---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "thunar"
local menu        = os.getenv("HOME") .. "/.config/rofi/launchers/type-2/launcher.sh"
local browser     = "zen-browser"
local barlayout   = os.getenv("HOME") .. "/.config/color-scheme/barlayout.sh"
local colorLaunch = os.getenv("HOME") .. "/.config/color-scheme/launch.sh"
local quickReload = os.getenv("HOME") .. "/.config/quickshell/reload.sh"
local wallCycle   = os.getenv("HOME") .. "/.config/color-scheme/wall-cycle.sh"
local hyprlock    = os.getenv("HOME") .. "/.config/hypr/hyprlock.sh"
local newbar      = os.getenv("HOME") .. "/.config/quickshell/new/reload.sh"
local shutdown    = "shutdown -h now"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod     = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
--hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(barlayout))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(colorLaunch))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(quickReload))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(newbar))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("foot"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("galculator"))
hl.bind(mainMod .. " + X", hl.dsp.global("quickshell:powermenu"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(wallCycle))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("quickshell -c OSD ipc call osd toggleRight"))
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("quickshell -c OSD ipc call osd toggleLeft"))

-- Quickshell Tact
hl.bind("ALT + S", hl.dsp.exec_cmd("qs -c tact ipc call bar toggleTime"))
hl.bind("ALT + A", hl.dsp.exec_cmd("qs -c tact ipc call bar toggleMedia"))
hl.bind("ALT + ESCAPE", hl.dsp.exec_cmd("qs -c tact ipc call bar closePill"))
hl.bind("ALT + X", hl.dsp.exec_cmd("qs -c tact ipc call bar togglePowerMenu"))
hl.bind("ALT + D", hl.dsp.exec_cmd("qs -c tact ipc call bar toggleLauncher"))
hl.bind("ALT + C", hl.dsp.exec_cmd("qs -c tact ipc call bar toggleControlCenter"))
hl.bind("ALT + I", hl.dsp.exec_cmd("qs -c tact ipc call bar toggleSettings"))
hl.bind("ALT + T", hl.dsp.exec_cmd("qs -c tact ipc call bar toggleTheme"))
hl.bind("ALT + W", hl.dsp.exec_cmd("qs -c tact ipc call bar toggleWallpaper"))
hl.bind("ALT + S", hl.dsp.global("quickshell:toggle_launcher"))
hl.bind("ALT + Q", hl.dsp.global("quickshell:close_all"))

-- Scrolling Layout
hl.bind(mainMod .. " + period", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + comma", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + F", hl.dsp.layout("colresize 1.0"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.layout("colresize 0.5"))
hl.bind(mainMod .. " + N", hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. " + P", hl.dsp.layout("colresize -conf"))

--SHIFT region
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd(hyprlock))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("sleep 0.5 && systemctl suspend"))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd(shutdown))
hl.bind(mainMod .. " + SHIFT + M",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
