local mainMod = "SUPER"
local scriptsDir = os.getenv("HOME") .. "/.bin" -- matches $scriptsDir = $HOME/.bin in keybinds.conf

-- Fullscreen
-- NOTE: the original conf line was `bind = $mainMod, F, fullscreen, centerwindow`.
-- "centerwindow" is not a valid param for the fullscreen dispatcher (it only ever
-- took 0/1/2, now "fullscreen"/"maximized" in the new API) — this looks like a typo
-- in the original .conf that Hyprland likely ignored/misparsed. Translated here as
-- a plain fullscreen toggle. Please verify this is the behavior you actually want.
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Discord passthrough (no modifier)
hl.bind("Scroll_Lock", hl.dsp.pass({ window = "class:^(discord)$" }))

-- App launches
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("kitty --class kitty.center"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(
	mainMod .. " + SHIFT + W",
	hl.dsp.exec_cmd("kitty --class kitty.center sh -c '" .. os.getenv("HOME") .. "/.bin/change-wallpaper'")
)
hl.bind("F8", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.bin/save-replay"))

-- Float + resize (exact) + center on one key (SUPER + P), fired in sequence like the
-- three stacked `bind = SUPER, P, exec, hyprctl dispatch ...` lines in the original conf.
-- Using exec_cmd for the exact resize since the documented hl.dsp.window.resize() only
-- takes relative x/y deltas, not an absolute "exact WxH" — this exec_cmd form is
-- guaranteed to behave identically to the old config.
hl.bind(mainMod .. " + P", function()
	hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
	hl.dispatch(hl.dsp.exec_cmd("hyprctl dispatch resizeactive exact 900 500"))
	hl.dispatch(hl.dsp.window.center())
end)

-- Session
hl.bind("CTRL + ALT + Delete", hl.dsp.exit())
hl.bind(mainMod .. " + Q", hl.dsp.window.close()) -- close active (not kill)

-- Screenshot
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))

-- Workspaces related
hl.bind("ALT + Tab", hl.dsp.window.cycle_next({ tiled = true })) -- ⚠️ VERIFY: original was `cyclenext, visible tiled all` — the "visible"/"all" modifiers aren't in the documented cycle_next() fields, so this may not be 100% equivalent
hl.bind(mainMod .. " + tab", hl.dsp.focus({ workspace = "m+1" })) -- ⚠️ VERIFY: "m+1"/"m-1" monitor-relative workspace selectors aren't explicitly documented for the new focus() API, but should pass through as a raw selector string
hl.bind(mainMod .. " + SHIFT + tab", hl.dsp.focus({ workspace = "m-1" }))

-- Dwindle Layout
hl.bind(mainMod .. " + I", hl.dsp.layout("togglesplit")) -- only works on dwindle layout
hl.bind(mainMod .. " + O", hl.dsp.layout("swapsplit")) -- only works on dwindle layout

-- Media controls using keyboard (locked = works while screen is locked, like `bindl` did)
-- hl.bind("xf86AudioPlayPause", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --pause"), { locked = true })
-- hl.bind("xf86AudioPause", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --pause"), { locked = true })
-- hl.bind("xf86AudioPlay", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --pause"), { locked = true })
-- hl.bind("xf86AudioNext", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --nxt"), { locked = true })
-- hl.bind("xf86AudioPrev", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --prv"), { locked = true })
-- hl.bind("xf86AudioStop", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --stop"), { locked = true })

-- Resize windows (repeating). resize() takes relative x/y deltas directly, matching
-- resizeactive's `-50 0` style params — no extra "relative" flag needed/documented.
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })

-- Move windows
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.move({ direction = "down" }))

-- Swap windows
hl.bind(mainMod .. " + ALT + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.swap({ direction = "down" }))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Special workspace
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mainMod .. " + U", hl.dsp.workspace.toggle_special())

-- The following mappings use key codes to better support various keyboard layouts.
-- 1 is code:10, 2 is code:11, etc. code:19 = key 0 -> workspace 10.
for i = 1, 10 do
	local code = "code:" .. (i + 9)

	-- Switch workspaces with mainMod + [0-9]
	hl.bind(mainMod .. " + " .. code, hl.dsp.focus({ workspace = i }))

	-- Move active window and follow to workspace with mainMod + SHIFT + [0-9]
	hl.bind(mainMod .. " + SHIFT + " .. code, hl.dsp.window.move({ workspace = i }))

	-- Move active window to a workspace silently with mainMod + CTRL + [0-9]
	-- (follow = false replicates the old movetoworkspacesilent dispatcher)
	hl.bind(mainMod .. " + CTRL + " .. code, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Move active window to a workspace silently mainMod + CTRL [ / ]
hl.bind(mainMod .. " + CTRL + bracketleft", hl.dsp.window.move({ workspace = "-1", follow = false }))
hl.bind(mainMod .. " + CTRL + bracketright", hl.dsp.window.move({ workspace = "+1", follow = false }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + period", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + comma", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- left click
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- right click
