local mainMod    = "SUPER"
local scriptsDir = os.getenv("HOME") .. "/.config/hypr/scripts"

-- Fullscreen
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ style = "centerwindow" }))  -- ⚠️ VERIFY style param name

-- Discord passthrough (no modifier)
hl.bind("Scroll_Lock", hl.dsp.pass({ window = "class:^(discord)$" }))

-- App launches
hl.bind(mainMod .. " + T",         hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("kitty --class kitty.center"))
hl.bind(mainMod .. " + SPACE",     hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("kitty --class kitty.center sh -c '" .. os.getenv("HOME") .. "/.bin/change-wallpaper'"))
hl.bind("F8",                      hl.dsp.exec_cmd(os.getenv("HOME") .. "/.bin/save-replay"))

-- Float + resize + center on one key (SUPER + P)
hl.bind(mainMod .. " + P", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.resize({ x = 900, y = 500 }))
hl.bind(mainMod .. " + P", hl.dsp.window.center())

-- Session
hl.bind("CTRL + ALT + Delete", hl.dsp.exit())   -- ⚠️ VERIFY: hl.dsp.exit()?
hl.bind(mainMod .. " + Q",     hl.dsp.window.close())

-- Screenshot
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))

-- Workspace navigation
-- hl.bind("ALT + Tab",                 hl.dsp.window.cycle_next({ visible = true, tiled = true }))
-- hl.bind(mainMod .. " + Tab",         hl.dsp.workspace.focus({workspace = "m+1"}))
-- hl.bind(mainMod .. " + SHIFT + Tab",  hl.dsp.workspace.focus({workspace = "m-1"}))

-- Special workspace magic (sequence intentional — standard Hyprland trick)
hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + M", hl.dsp.window.move({ workspace = "+0" }))
hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + M", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special("magic"))

-- Layout: Dwindle
hl.bind(mainMod .. " + I", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + O", hl.dsp.layout("swapsplit"))

-- Media controls (locked)
hl.bind("XF86AudioPause",     hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --pause"), { locked = true })
hl.bind("XF86AudioPlay",      hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --pause"), { locked = true })
hl.bind("XF86AudioNext",      hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --nxt"),   { locked = true })
hl.bind("XF86AudioPrev",      hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --prv"),   { locked = true })
hl.bind("XF86AudioStop",      hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --stop"),  { locked = true })

-- Resize windows (repeating)
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({x = -50, y = 0, relative = true}), { repeating = true })  -- ⚠️ VERIFY delta syntax
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({x = 50, y = 0, relative = true}),  { repeating = true })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({x = 0, y = -50, relative = true}), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({x = 0, y = 50, relative = true}),  { repeating = true })

-- Move windows
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.move({ direction = "left" }))   -- ⚠️ VERIFY: keyboard movewindow syntax
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.move({ direction = "down" }))

-- Swap windows
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.swap({ direction = "left" }))   -- ⚠️ VERIFY: hl.dsp.window.swap()?
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + ALT + up",    hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + ALT + down",  hl.dsp.window.swap({ direction = "down" }))

-- Move focus
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Special workspace (unnamed toggle)
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mainMod .. " + U",         hl.dsp.workspace.toggle_special())

-- Switch/move/silent-move workspaces via keycodes (1-10)
for i = 1, 10 do
    local code = "code:" .. (i + 9)  -- code:10 = 1 ... code:19 = 0
    hl.bind(mainMod .. " + " .. code,                hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. code,        hl.dsp.window.move({ workspace = i }))
    hl.bind(mainMod .. " + CTRL + " .. code,         hl.dsp.window.move({ workspace = i }))  -- ⚠️ VERIFY silent flag
end

-- Move/resize with mouse drag
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })