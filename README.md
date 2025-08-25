# dotfiles-hyprland
My dotfiles for hyprland in Arch Linux

## Preview
<img width="1920" height="1080" alt="2025-08-24-133922_hyprshot" src="https://github.com/user-attachments/assets/f9d143aa-9166-4b6b-895a-b30532e8603e" />

## Instructions
1. Make a backup of your dotfiles.
2. Copy the dotfiles from this repo to the appropriate location.
3. Install the dependencies.
4. Either restart or logout and login (Recommended to restart).

## Dependencies
### Pacman pkgs
```
sudo pacman -S \
adw-gtk-theme \
archlinux-xdg-menu \
blueman \
bluez-utils \
breeze \
brightnessctl \
cliphist \
dolphin \
gnome-keyring \
hypridle \
hyprland \
hyprlock \
hyprpaper \
hyprpicker \
hyprpolkitagent \
hyprshot \
hyprsunset \
papirus-icon-theme \
xdg-desktop-portal-hyprland \
kate \
kio-admin \
kitty \
loupe \
nwg-dock-hyprland \
nwg-look \
pavucontrol \
swaync \
switcheroo-control \
udiskie \
waybar \
wofi \
zsh
```
### AUR pkgs
```
yay -S \
darkly-bin \
hyprsysteminfo \
oh-my-zsh-git \
oh-my-zsh-powerline-theme-git \
qt5ct-kde \
qt6ct-kde \
wlogout \
wofi-emoji
```

### Extra pkgs
- Thumbnails some file types for dolphin  
(need to enable in dolphin settings after installation)
```
sudo pacman -S \
ffmpegthumbs \
icoutils \
kdegraphics-thumbnailers \
kimageformats \
libappimage
```
```
yay -S \
kde-thumbnailer-apk
```