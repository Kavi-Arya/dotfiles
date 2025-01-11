#!/bin/bash

# TODO: Neovim config, firefox css config

set -e  # Exit immediately if a command exits with a non-zero status.
set -o pipefail  # Catch errors in pipelines.

# Logging function for better output visibility
log() {
  echo "[INFO] $1"
}

log '---------Expoting Shit to PATH---------'
export PATH=/opt/homebrew/bin/:$PATH
export PATH=/users/augest/.nix-profile/bin/:$PATH


log '---------Installing Brew---------'
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  log 'Homebrew is already installed.'
fi

log 'Installing essential packages with Brew...'
brew install git stow

if [ ! -d "$HOME/.clones/Macdots" ]; then
  log 'Cloning Macdots repository...'
  cd "$HOME/.clones/" || exit
  git clone --depth 1 "https://github.com/Kavi-Arya/Macdots"
else
  log 'Macdots repository already exists.'
fi

log '---------Installing Nix---------'
if ! command -v nix &>/dev/null; then
  sh <(curl -L https://nixos.org/nix/install)
else
  log 'Nix is already installed.'
fi

# Function to move and set up dotfiles
setup_dotfiles() {
  log '---------Running Setup Dotfiles---------'
  mkdir -p "$HOME/.config"
  mkdir -p "$HOME/.clones"
  cp -r "$HOME/.clones/Macdots/dotfiles" "$HOME"
  cd "$HOME/dotfiles" || exit
  stow .
}

# Function to install packages from Brew lists
install_brew_packages() {
  log '---------Installing Brew Packages---------'
  pkgs_file="$HOME/.clones/Macdots/src/pkgs.txt"
  casks_file="$HOME/.clones/Macdots/src/casks.txt"

  if [[ -f "$pkgs_file" ]]; then
    xargs brew install < "$pkgs_file"
  else
    log "Package file $pkgs_file not found. Skipping."
  fi

  if [[ -f "$casks_file" ]]; then
    xargs brew install --cask < "$casks_file"
  else
    log "Cask file $casks_file not found. Skipping."
  fi
}

# Function to install shell color scripts
install_shell_color_scripts() {
  log '---------Installing Shell Color Scripts---------'
  shell_color_dir="$HOME/.clones/Macdots/src/shell-color-scripts"

  if [[ -d "$shell_color_dir" ]]; then
    cd "$shell_color_dir" || exit
    sudo make install
  else
    log "Shell color script directory $shell_color_dir not found. Skipping."
  fi
}

# Function to apply macOS defaults
apply_macos_defaults() {
  log '---------Applying macOS Defaults---------'
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
  defaults write -globalDomain AppleAccentColor -bool True
}

# Function to start services
start_services() {
  log '---------Starting Services---------'
  if command -v sketchybar &>/dev/null; then
    brew services restart sketchybar
  fi

  if command -v yabai &>/dev/null; then
    yabai --start-service
  fi

  if command -v skhd &>/dev/null; then
    skhd --start-service
  fi
}

setup_dotfiles
install_brew_packages
install_shell_color_scripts
apply_macos_defaults
start_services

echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 "$(which yabai)" | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai

log 'Installation and configuration completed successfully!'
