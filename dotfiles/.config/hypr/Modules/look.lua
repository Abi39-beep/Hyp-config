local Colors = require("Modules.Colors")
-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in          = 2,
        gaps_out         = 10,

        border_size      = 1,

        col              = {
            active_border   = Colors.bg4,
            inactive_border = Colors.grey2,
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing    = false,

        layout           = "scrolling",
    },

    scrolling = {
        fullscreen_on_one_column = true,
        column_width = 0.5,
        focus_fit_method = 1,
        explicit_column_widths = "0.333, 0.50, 0.667, 1.0",
    },

    decoration = {
        rounding           = 15,
        rounding_power     = 3,

        -- Change transparency of focused and unfocused windows
        active_opacity     = 0.75,
        inactive_opacity   = 0.65,
        fullscreen_opacity = 1.0,

        shadow             = {
            enabled      = false,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur               = {
            enabled           = true,
            size              = 10,
            passes            = 3,
            ignore_opacity    = true,
            new_optimizations = true,
            xray              = false,
            noise             = 0.0117,
            contrast          = 0.9,
            brightness        = 0.8,
            vibrancy          = 0.2,
            vibrancy_darkness = 0.0,
            popups            = true,
        },
    },

    animations = {
        enabled = true,
    },
})

-- ============================
-- BEZIER CURVES
-- syntax: { { x1, y1 }, { x2, y2 } }
-- ============================
hl.curve("smoothOut", { type = "bezier", points = { { 0.36, 0 }, { 0.66, -0.56 } } })
hl.curve("smoothIn", { type = "bezier", points = { { 0.25, 1 }, { 0.5, 1 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("softSnap", { type = "bezier", points = { { 0.4, 0 }, { 0.2, 1 } } })
hl.curve("fluent", { type = "bezier", points = { { 0.0, 0.0 }, { 0.2, 1.0 } } })
hl.curve("easeInOutExpo", { type = "bezier", points = { { 0.87, 0 }, { 0.13, 1 } } })

-- ============================
-- ANIMATIONS
-- ============================

-- Global switch (equivalent to enabled = yes)
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })

-- Windows
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "overshot", style = "popin 80%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "overshot", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "smoothOut", style = "popin 95%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "softSnap" })

-- Layers
hl.animation({ leaf = "layersIn", enabled = true, speed = 7, bezier = "smoothIn", style = "slide right" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 8, bezier = "softSnap", style = "slide right" })

-- Fade
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "smoothIn" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 4, bezier = "smoothIn" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 4, bezier = "smoothOut" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 4, bezier = "smoothIn" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 4, bezier = "smoothIn" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 4, bezier = "smoothIn" })
hl.animation({ leaf = "fadeDpms", enabled = true, speed = 4, bezier = "smoothIn" })
hl.animation({ leaf = "fadeLayers", enabled = true, speed = 3, bezier = "softSnap" })

-- Workspaces
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "overshot", style = "slidefade 30%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "overshot", style = "slidefadevert 30%" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})
