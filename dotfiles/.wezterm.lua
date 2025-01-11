local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config)
-- example enable spotify module
bar.apply_to_config(
  config,
  {
    modules = {
      spotify = {
        enabled = true,
      },
    },
  }
)

return {
  window_padding = {
    left = 7,
    right = 7,
    top = 7,
    bottom = 7,
  },
  inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.8,
  },
  enable_tab_bar = false,
  font = wezterm.font("Comic Code"),
  font_size = 16,
  window_decorations = "RESIZE",
  window_background_opacity = 1,
  warn_about_missing_glyphs=false,
  -- color_scheme = "vscode-dark",
  color_scheme = 'rose-pine',
  max_fps = 120,
  -- color_schemes = {
  --   ["gruvbox_material_dark_hard"] = {
  --     foreground = "#D4BE98",
  --     background = "#1D2021",
  --     cursor_bg = "#D4BE98",
  --     cursor_border = "#D4BE98",
  --     cursor_fg = "#1D2021",
  --     selection_bg = "#D4BE98" ,
  --     selection_fg = "#3C3836",
  --
  --     ansi = {"#1d2021","#ea6962","#a9b665","#d8a657", "#7daea3","#d3869b", "#89b482","#d4be98"},
  --     brights = {"#eddeb5","#ea6962","#a9b665","#d8a657", "#7daea3","#d3869b", "#89b482","#d4be98"}
  --   },
  -- },
}
