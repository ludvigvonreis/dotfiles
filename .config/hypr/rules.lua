hl.window_rule({
    name  = "kitty-center",
    match = { class = "^kitty.center*" },
    float  = true,
    center = true,
    size   = "900 500",
})

hl.window_rule({
    name  = "bitwarden-center",
    match = { title = "^*.?Bitwarden" },
    opacity = 0.2,
    float   = true,
    center  = true,
    size    = "900 500",
})

hl.window_rule({
    name    = "minecraft-monitor",
    match   = { class = "^Minecraft.*" },
    monitor = "DP-2",
})

hl.window_rule({
    name    = "steam-monitor",
    match   = { class = "^steam_app_.*" },
    monitor = "DP-2",
})

hl.window_rule({
    name  = "steam-tile",
    match = { title = "Steam" },
    tile  = true,
})

hl.window_rule({
    name  = "steam-stay-focused",
    match = {
        title = "^()$",
        class = "^(steam)$",
    },
    stay_focused = true,
    min_size     = {1, 1},
})

hl.window_rule({
    name           = "suppress-maximize",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Layer rules
hl.layer_rule({
    name         = "blur-notifications",
    match        = { namespace = "notifications" },
    blur         = true,
    ignore_alpha = 0,
    xray         = false,
})

hl.layer_rule({
    name         = "blur-waybar",
    match        = { namespace = "waybar" },
    blur         = true,
    ignore_alpha = 0,
    xray         = false,
})

hl.layer_rule({
    name         = "blur-rofi",
    match        = { namespace = "rofi" },
    blur         = true,
    ignore_alpha = 0,
    xray         = false,
})

hl.layer_rule({
    name         = "blur-music-popup",
    match        = { namespace = "music-popup" },
    blur         = true,
    ignore_alpha = 0,
    xray         = false,
})