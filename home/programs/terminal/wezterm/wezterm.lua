local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.font = wezterm.font("monospace")
config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.8

return config
