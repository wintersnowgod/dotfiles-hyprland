#!/usr/bin/env bash

# Updates Arch repo, AUR, and Flatpak packages
# Config: Set your AUR helper here (paru, yay, or empty if none)
AUR_HELPER="yay"
# {} is AUR_HELPER leave it unchanged. just add the required flags after it
AUR_UPGRADE_CMD="{} -Sua --needed --answerupgrade None --answerclean All --answerdiff None --noremovemake --sudoloop --noconfirm --mflags \"--noconfirm\""

# Colors for output
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
BOLD='\033[1m'
RESET='\033[0m'

print_msg() {
  echo -e "\n${BLUE}${BOLD}>>> $1${RESET}"
}

print_done() {
  echo -e "\n${GREEN}${BOLD}✔ $1${RESET}"
}

print_warn() {
  echo -e "\n${YELLOW}${BOLD}! $1${RESET}"
}

print_error() {
  echo -e "\n${RED}${BOLD}✘ $1${RESET}"
}

print_finished() {
  echo -e "\n${GREEN}${BOLD}::$1::${RESET}"
}

update_arch() {
  print_msg "Updating Arch repo packages..."
  if sudo pacman -Syu --noconfirm; then
    print_done "Arch repo packages updated"
  else
    print_error "Failed to update Arch repo packages"
  fi
}

update_aur() {
  if [[ -n "$AUR_HELPER" && $(command -v "$AUR_HELPER") ]]; then
    print_msg "Updating AUR packages with $AUR_HELPER..."

    # Replace {} with AUR_HELPER in AUR_UPGRADE_CMD
    local cmd="${AUR_UPGRADE_CMD//\{\}/$AUR_HELPER}"

    # Run the command
    if eval "$cmd"; then
      print_done "AUR packages updated"
    else
      print_error "Failed to update AUR packages"
    fi
  else
    print_warn "No AUR helper found or not set. Skipping AUR updates."
  fi
}

update_flatpak() {
  if command -v flatpak >/dev/null; then
    print_msg "Updating Flatpak packages..."
    if flatpak update -y; then
      print_done "Flatpak packages updated"
    else
      print_error "Failed to update Flatpak packages"
    fi
  else
    print_warn "Flatpak not installed. Skipping Flatpak updates."
  fi
}

main() {
  update_arch
  update_aur
  update_flatpak
  print_finished "Press any key to EXIT"
  read -r
}
# Only run main when this script is called directly, *not* inside systemd-inhibit call recursion
if [[ $INHIBITED != "yes" ]]; then
  export INHIBITED="yes"
  UPGRADE_PROGRESS="System update running"
  exec systemd-inhibit --what=idle:sleep:shutdown --who="Update Packages" --why="$UPGRADE_PROGRESS" "$0"
fi
main
