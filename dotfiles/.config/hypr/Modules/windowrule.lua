--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name           = "suppress-maximize-events",
    match          = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- ============================
-- SPECIFIC APP WINDOW RULES
-- ============================

--Firefox
hl.window_rule({
    match = { class = "^(firefox)$" },
    opaque = true,
})

--Zen browser
hl.window_rule({
    match = { class = "^(zen)$" },
    opaque = true,
})

-- Onlyoffice
hl.window_rule({
    match  = { class = "^(ONLYOFFICE)$" },
    opaque = true,
})

hl.window_rule({
    match  = { class = "^(DesktopEditors)$", title = "^(Open Document|Save As)$" },
    float  = true,
    center = true,
})

-- Thunar
hl.window_rule({
    match  = { class = "^(thunar)$", title = "^(.*Rename.*)$" },
    float  = true,
    center = true,
})

-- Papers Document-viewer
hl.window_rule({
    match  = { class = "^(org.gnome.Papers)$" },
    opaque = true,
})

-- FreeCAD
hl.window_rule({
    match  = { class = "^(org.freecad.FreeCAD)$" },
    opaque = true,
})

--Ristretto
hl.window_rule({
    match  = { class = "^(org.xfce.ristretto)$" },
    opaque = true,
})

--Celluloid
hl.window_rule({
    match  = { class = "^(io.github.celluloid_player.Celluloid)$" },
    opaque = true,
})

-- Galculator
hl.window_rule({
    match  = { class = "^(galculator)$" },
    float  = true,
    center = true,
})

--------------------------------
---------- LAYER RULES ---------
--------------------------------

-- Rofi (Rules combined into one block)
hl.layer_rule({
    match        = { namespace = "^(rofi)$" },
    blur         = true,
    ignore_alpha = 0,
    animation    = "slide bottom"
})

-- Logout Dialog
hl.layer_rule({
    match = { namespace = "^(logout_dialog)$" },
    blur  = true,
})

-- Quickshell OSD layer_rule
hl.layer_rule({
    match = { namespace = "^(leftosd)$" },
    blur = true,
    ignore_alpha = 0,
    animation = "slide left"
})

hl.layer_rule({
    match = { namespace = "^(rightosd)$" },
    blur = true,
    ignore_alpha = 0,
})

hl.layer_rule({
    match = { namespace = "^(bottomosd)$" },
    blur = true,
    ignore_alpha = 0,
})

hl.layer_rule({
    match = { namespace = "^(workspaceosd)$" },
    blur = true,
    ignore_alpha = 0,
    animation = "slide top"
})

hl.layer_rule({
    match = { namespace = "^(qubarmorden)$" },
    blur = true,
    ignore_alpha = 0.5,
})

hl.layer_rule({
    match = { namespace = "^(dashboard)$" },
    blur = true,
    ignore_alpha = 0,
})

hl.layer_rule({
    match = { namespace = "^(normal2)$" },
    blur = true,
    ignore_alpha = 0,
})

hl.layer_rule({
    match = { namespace = "^(pill)$" },
    blur = true,
    ignore_alpha = 0.5,
})

hl.layer_rule({
    match = { namespace = "^(simp)$" },
    blur = true,
    ignore_alpha = 0,
})
