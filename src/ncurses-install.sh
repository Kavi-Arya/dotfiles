#!/bin/bash

# Ensure the ncurses library is available
if ! command -v dialog &>/dev/null; then
  echo "[ERROR] 'dialog' is required but not installed. Install it with 'brew install dialog'."
  exit 1
fi

# Logging function for better output visibility
log() {
  echo "[INFO] $1"
}

# Function to show progress during execution
show_progress() {
  dialog --infobox "$1" 5 50
  sleep 1
}

# Function to install Brew
install_brew() {
  show_progress "Installing Homebrew..."
  log "Installing Homebrew..."
  if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    log "Homebrew installation completed."
    dialog --msgbox "Homebrew installation completed." 6 50
  else
    log "Homebrew is already installed."
    dialog --msgbox "Homebrew is already installed." 6 50
  fi
}

# Function to install additional packages via Brew
install_additional_packages() {
  log "Prompting user for additional packages to install."
  additional_pkgs=$(dialog --inputbox "Enter additional packages to install (space-separated):" 10 50 3>&1 1>&2 2>&3)

  if [[ -n "$additional_pkgs" ]]; then
    show_progress "Installing additional packages..."
    for pkg in $additional_pkgs; do
      if brew list --formula | grep -q "^$pkg$"; then
        log "$pkg is already installed. Skipping."
      else
        if brew install "$pkg"; then
          log "$pkg installed successfully."
          dialog --msgbox "Additional packages installation completed." 6 50
        else
          log "[ERROR] Failed to install $pkg."
          dialog --msgbox "Failed to install package: $pkg" 6 50
        fi
      fi
    done
  else
    log "No additional packages specified. Skipping."
    dialog --msgbox "No additional packages specified. Skipping." 6 50
  fi
}

# Function to install Nix
install_nix() {
  show_progress "Installing Nix..."
  log "Installing Nix..."
  if ! command -v nix &>/dev/null; then
    # sh <(curl -L https://nixos.org/nix/install)
    log "Nix installation completed."
    dialog --msgbox "Nix installation completed." 6 50
  else
    log "Nix is already installed."
    dialog --msgbox "Nix is already installed." 6 50
  fi
}

# Function to clone Macdots
clone_macdots() {
  show_progress "Cloning Macdots repository..."
  log "Cloning Macdots repository..."
  mkdir -p "$HOME/.clones"
  if [ ! -d "$HOME/.clones/Macdots" ]; then
    git clone --depth 1 "https://github.com/Kavi-Arya/Macdots" "$HOME/.clones/Macdots"
    log "Macdots repository cloned successfully."
    dialog --msgbox "Macdots repository cloned successfully." 6 50
  else
    log "Macdots repository already exists."
    dialog --msgbox "Macdots repository already exists." 6 50
  fi
}

# Function to apply macOS defaults
apply_macos_defaults() {
  show_progress "Applying macOS defaults..."
  log "Applying macOS defaults..."
  defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.spaces spans-displays -bool false
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock "mru-spaces" -bool "false"
  defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
  defaults write com.apple.LaunchServices LSQuarantine -bool false
  defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
  defaults write NSGlobalDomain KeyRepeat -int 1
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
  defaults write NSGlobalDomain _HIHideMenuBar -bool true
  defaults write com.apple.screencapture location -string "$HOME/Desktop"
  defaults write com.apple.screencapture disable-shadow -bool true
  defaults write com.apple.screencapture type -string "png"
  defaults write com.apple.finder DisableAllAnimations -bool true
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
  defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
  defaults write com.apple.Finder AppleShowAllFiles -bool true
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
  defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
  defaults write com.apple.finder ShowStatusBar -bool false
  defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool YES
  defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
  defaults write com.apple.Safari IncludeDevelopMenu -bool true
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
  defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
  defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
  defaults write -globalDomain AppleAccentColor -bool False
  defaults write -globalDomain AppleHighlightColor -string "Orange"
  log "macOS defaults applied successfully."
  dialog --msgbox "macOS defaults applied successfully." 6 50
}

# Function to install packages from Brew lists
install_brew_packages() {
  show_progress "Installing Brew packages..."
  log "Installing Brew packages..."
  pkgs_file="$HOME/.clones/Macdots/src/pkgs.txt"
  casks_file="$HOME/.clones/Macdots/src/casks.txt"

  if [[ -f "$pkgs_file" ]]; then
    while IFS= read -r pkg; do
      if brew list --formula | grep -q "^$pkg$"; then
        log "$pkg is already installed. Skipping."
      else
        if brew install "$pkg"; then
          log "$pkg installed successfully."
        else
          log "[ERROR] Failed to install $pkg."
          dialog --msgbox "Failed to install package: $pkg" 6 50
        fi
      fi
    done < "$pkgs_file"
    dialog --msgbox "Brew packages installed successfully." 6 50
  else
    log "Package file $pkgs_file not found. Skipping."
    dialog --msgbox "Package file $pkgs_file not found. Skipping." 6 50
  fi

  if [[ -f "$casks_file" ]]; then
    while IFS= read -r cask; do
      if brew list --cask | grep -q "^$cask$"; then
        log "$cask is already installed. Skipping."
      else
        if brew install --cask "$cask"; then
          log "$cask installed successfully."
        else
          log "[ERROR] Failed to install $cask."
          dialog --msgbox "Failed to install cask: $cask" 6 50
        fi
      fi
    done < "$casks_file"
    dialog --msgbox "Brew cask packages installed successfully." 6 50
  else
    log "Cask file $casks_file not found. Skipping."
    dialog --msgbox "Cask file $casks_file not found. Skipping." 6 50
  fi
}

# Function to run setup dotfiles
setup_dotfiles() {
  show_progress "Setting up dotfiles..."
  log "Setting up dotfiles..."
  mkdir -p "$HOME/.config"
  cp -r "$HOME/.clones/Macdots/dotfiles" "$HOME"
  cd "$HOME/dotfiles" || exit
  stow .
  log "Dotfiles setup completed successfully."
  dialog --msgbox "Dotfiles setup completed successfully." 6 50
}

# Function to start services
start_services() {
  show_progress "Starting services..."
  log "Starting services..."
  if command -v sketchybar &>/dev/null; then
    brew services restart sketchybar
  fi
  if command -v yabai &>/dev/null; then
    yabai --start-service
  fi
  if command -v skhd &>/dev/null; then
    skhd --start-service
  fi
  log "Services started successfully."
  dialog --msgbox "Services started successfully." 6 50
}

# Main ncurses interface
while true; do
  choice=$(dialog --clear \
    --title "Mac Setup Script" \
    --menu "Choose an option:" 20 52 7 \
    1 "Install Homebrew" \
    2 "Install Nix" \
    3 "Clone Macdots Repository" \
    4 "Set Up Dotfiles" \
    5 "Install Brew Packages" \
    6 "Install Additional Packages" \
    7 "Apply macOS Defaults" \
    8 "Start Services" \
    9 "Exit" \
    3>&1 1>&2 2>&3)

  clear
  case $choice in
    1)
      install_brew
      ;;
    2)
      install_nix
      ;;
    3)
      clone_macdots
      ;;
    4)
      setup_dotfiles
      ;;
    5)
      install_brew_packages
      ;;
    6)
      install_additional_packages
      ;;
    7)
      apply_macos_defaults
      ;;
    8)
      start_services
      ;;
    9)
      exit
      ;;
    *)
      log "Invalid option. Please try again."
      ;;
  esac

done

dialog --msgbox "Setup script completed successfully!" 6 50
