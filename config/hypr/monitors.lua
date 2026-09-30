-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 2
local omarchy_monitor_scale = 2

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })

hl.monitor({ output = "desc:Dell Inc. DELL S3225QC HY5D444", mode = "3840x2160@60", position = "0x0",    scale = omarchy_monitor_scale }) -- left external
hl.monitor({ output = "desc:Dell Inc. DELL S3225QC GY5D444", mode = "3840x2160@60", position = "2560x0", scale = omarchy_monitor_scale }) -- right external
hl.monitor({ output = "eDP-1", mode = "2880x1800@60", position = "1600x1440", scale = omarchy_monitor_scale }) -- laptop, centered below

hl.workspace_rule({ workspace = "1", monitor = "desc:Dell Inc. DELL S3225QC GY5D444", default = true })
hl.workspace_rule({ workspace = "2", monitor = "desc:Dell Inc. DELL S3225QC HY5D444", default = true })
