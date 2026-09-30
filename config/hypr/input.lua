-- Keep only your personal input overrides here. Uncommented settings below
-- replace Omarchy's defaults.

-- Keyboard layout and options.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
  input = {
    kb_layout = "us",
    kb_variant = "altgr-intl",
  },
})

-- Clavier Bluetooth Epomaker Tide Alice
-- The keyboard exposes two input devices; the rule must cover both.
-- kb_options on a device replaces the global ones, so keep Omarchy's defaults
-- (compose:caps, shift:both_capslock_cancel) and add the remap.
for _, name in ipairs({ "hs-tide-alice", "hs-tide-alice-keyboard" }) do
  hl.device({
    name       = name,
    kb_layout  = "us",
    kb_variant = "altgr-intl",

    -- Remap : Left Alt <-> Left Super
    kb_options = "compose:caps,shift:both_capslock_cancel,altwin:swap_lalt_lwin",
  })
end

-- App-specific touchpad scroll speeds.
-- o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
-- o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })

-- Enable touchpad gestures for changing workspaces.
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
-- hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Enable touchpad gestures for moving focus (helpful on scrolling layout).
-- hl.gesture({ fingers = 3, direction = "left", action = function() hl.dispatch(hl.dsp.focus({ direction = "l" })) end })
-- hl.gesture({ fingers = 3, direction = "right", action = function() hl.dispatch(hl.dsp.focus({ direction = "r" })) end })
