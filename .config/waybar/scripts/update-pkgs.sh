#!/usr/bin/env bash

# Updates Arch repo, AUR, and Flatpak packages
# Config: Set your AUR helper here (paru, yay, or empty if none)
AUR_HELPER="yay"
# {} is AUR_HELPER leave it unchanged. just add the required flags after it
AUR_UPGRADE_CMD="{} -Sua --needed --answerupgrade None --answerclean All --answerdiff None --noremovemake --cleanafter --sudoloop --noconfirm --mflags \"--noconfirm\""

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
  (
    trap 'exit 130' INT  # if Ctrl-C pressed inside, return exit code 130
    sudo pacman -Syu --noconfirm
  )
  status=$?
  if [[ $status -eq 0 ]]; then
    print_done "Arch repo packages updated"
  elif [[ $status -eq 130 ]]; then
    print_error "Arch repo update interrupted"
  else
    print_error "Failed to update Arch repo packages"
  fi
}

update_aur() {
  if [[ -n "$AUR_HELPER" && $(command -v "$AUR_HELPER") ]]; then
    print_msg "Updating AUR packages with $AUR_HELPER..."
    local cmd="${AUR_UPGRADE_CMD//\{\}/$AUR_HELPER}"
    (
      trap 'exit 130' INT
      eval "$cmd"
    )
    status=$?
    if [[ $status -eq 0 ]]; then
      print_done "AUR packages updated"
    elif [[ $status -eq 130 ]]; then
      print_error "AUR update interrupted"
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
    (
      trap 'exit 130' INT
      flatpak update -y
    )
    status=$?
    if [[ $status -eq 0 ]]; then
      print_done "Flatpak packages updated"
    elif [[ $status -eq 130 ]]; then
      print_error "Flatpak update interrupted"
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
  exit 0
}

# Prevent system from sleeping down during the update process
if [[ -z "$INHIBIT_WRAPPER" ]]; then
  exec systemd-inhibit --what=shutdown:sleep --who="System Update" \
    --why="Prevent shutdown/sleep during system upgrade" \
    env INHIBIT_WRAPPER=1 "$0" "$@"
fi

main