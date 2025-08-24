#!/bin/bash

CACHE_FILE="/tmp/waybar-updates-cache"
CHECKING_FILE="/tmp/waybar-updates-checking"

refresh_updates() {
    # Create checking flag
    echo "checking" > "$CHECKING_FILE"
    pkill -RTMIN+8 waybar
    rm -f "$CACHE_FILE"
    {
        echo "::REPO::"
        checkupdates 2>/dev/null
        echo "::AUR::"
        yay -Qum 2>/dev/null
        echo "::FLATPAK::"
        flatpak remote-ls --updates --columns=application 2>/dev/null
    } > "$CACHE_FILE"

    rm -f "$CHECKING_FILE"
    pkill -RTMIN+8 waybar
}

run_update() {
    kitty sh -c "$HOME/.config/waybar/scripts/update-pkgs.sh"
    # Refresh updates after update completes
    echo '{ "text": "󰑓", "tooltip": "Checking for updates..." }'
    refresh_updates
    exit 0
}

case "$1" in
    --refresh)
        echo '{ "text": "󰑓", "tooltip": "Checking for updates..." }'
        # Run refresh in background so script exits now (loading icon shows)
        refresh_updates &
        exit 0
        ;;
    --update)
        run_update
        exit 0
        ;;
esac

# Show loading icon if currently checking
if [[ -f "$CHECKING_FILE" ]]; then
    echo '{ "text": "󰑓", "tooltip": "Checking for updates..." }'
    exit 0
fi

# Ensure cache exists (will trigger refresh which prints loading icon and exits)
[[ ! -f "$CACHE_FILE" ]] && {
    echo '{ "text": "󰑓", "tooltip": "Checking for updates..." }'
    refresh_updates &
    exit 0
}

# Parse cached update sections
REPO=$(awk '/::REPO::/{f=1;next}/::AUR::/{f=0}f' "$CACHE_FILE")
AUR=$(awk '/::AUR::/{f=1;next}/::FLATPAK::/{f=0}f' "$CACHE_FILE")
FLATPAK=$(awk '/::FLATPAK::/{f=1;next}f' "$CACHE_FILE")

REPO_COUNT=$(echo "$REPO" | grep -cve '^\s*$') || REPO_COUNT=0
AUR_COUNT=$(echo "$AUR" | grep -cve '^\s*$') || AUR_COUNT=0
FLATPAK_COUNT=$(echo "$FLATPAK" | grep -cve '^\s*$') || FLATPAK_COUNT=0
TOTAL=$((REPO_COUNT + AUR_COUNT + FLATPAK_COUNT))

if [[ $TOTAL -eq 0 ]]; then
    echo '{ "text": "󰚰 0", "tooltip": "System is up to date ✨\nScroll up to check for updates\nMiddle click to update system" }'
    exit 0
fi

# Build tooltip string
TOOLTIP="󰣇 Repo ($REPO_COUNT)"
[[ $REPO_COUNT -gt 0 ]] && TOOLTIP+="\n$REPO"
TOOLTIP+="\n\n AUR ($AUR_COUNT)"
[[ $AUR_COUNT -gt 0 ]] && TOOLTIP+="\n$AUR"
TOOLTIP+="\n\n Flatpak ($FLATPAK_COUNT)"
[[ $FLATPAK_COUNT -gt 0 ]] && TOOLTIP+="\n$FLATPAK"

ESCAPED_TOOLTIP=$(echo -e "$TOOLTIP" | jq -Rs .)
echo "{ \"text\": \"󰚰 $TOTAL\", \"tooltip\": $ESCAPED_TOOLTIP }"
