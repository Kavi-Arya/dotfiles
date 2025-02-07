---@type ChadrcConfig
local M = {}

function M.check_environment()
  local xorg_running = io.popen("pgrep -x dwm"):read("*a")
  local wayland_running = io.popen("pgrep -x Hyprland"):read("*a")

  if xorg_running ~= "" then
    -- print("Detected Xorg environment.")
    M.base46 = { theme = "vscode_dark" }
  elseif wayland_running ~= "" then
    -- print("Detected Wayland environment.")
    M.base46 = { theme = "chadwal" }
  else
    print("No supported environment detected.")
    M.base46 = { theme = "gruvchad" } -- Fallback theme
  end
end

M.check_environment()
return M
