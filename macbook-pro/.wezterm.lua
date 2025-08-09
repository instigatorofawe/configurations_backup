local wezterm = require 'wezterm'

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Color scheme
config.colors = {
  foreground = '#f8f8f2',
  background = '#2c2525',
  
  ansi = {
    '#2c2525', -- black
    '#fd6883', -- red
    '#adda78', -- green
    '#f9cc6c', -- yellow
    '#70b0f3', -- blue
    '#eba8eb', -- magenta
    '#85dacc', -- cyan
    '#fff1f3', -- white
  },
  
  brights = {
    '#72696a', -- bright black
    '#fd6883', -- bright red
    '#adda78', -- bright green
    '#f9cc6c', -- bright yellow
    '#70b0f3', -- bright blue
    '#a8a9eb', -- bright magenta
    '#85dacc', -- bright cyan
    '#fff1f3', -- bright white
  },
}

-- Font configuration
config.font = wezterm.font('DejaVuSansM Nerd Font')
config.font_size = 13

-- Window configuration
config.window_background_opacity = 1.0
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true


return config
