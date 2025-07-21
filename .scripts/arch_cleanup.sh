#!/bin/bash

# Arch Linux System Cleanup Script
# Run with sudo or as root

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${RED}This script must be run as root!${NC}"
    exit 1
fi

echo -e "${YELLOW}Arch Linux System Cleanup Script${NC}"
echo -e "${YELLOW}--------------------------------${NC}"
echo "This script will perform the following actions:"
echo "1. Remove orphaned packages"
echo "2. Clean package cache"
echo "3. Clean Flatpak unused packages"
echo "4. Clean systemd journal logs"
echo "5. Clean temporary files"
echo "7. Remove old config backup files"
echo "8. Clean AUR build files (if yay is installed)"
echo "9. Remove broken symlinks"
echo "10. Remove old kernels (keeping current and one previous)"
echo ""
read -p "Do you want to continue? [y/N] " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}Aborting cleanup.${NC}"
    exit 0
fi

# 1. Remove orphaned packages
echo -e "${GREEN}>>> Removing orphaned packages...${NC}"
orphaned=$(pacman -Qdtq)
if [ -z "$orphaned" ]; then
    echo "No orphaned packages found."
else
    echo "The following orphaned packages will be removed:"
    echo "$orphaned"
    pacman -Rns --noconfirm $orphaned
fi

# 2. Clear package cache (keep only current versions)
echo -e "${GREEN}>>> Cleaning package cache...${NC}"
pacman -Sc --noconfirm

# 3. Clean Flatpak unused packages
if command -v flatpak &> /dev/null; then
    echo -e "${GREEN}>>> Cleaning Flatpak unused packages...${NC}"
    flatpak remove --unused -y
else
    echo "Flatpak not installed, skipping."
fi

# 4. Clean systemd journal logs (keep last 50MB)
echo -e "${GREEN}>>> Cleaning systemd journal logs...${NC}"
journalctl --vacuum-size=50M

# 5. Clean temporary files
echo -e "${GREEN}>>> Cleaning temporary files...${NC}"
rm -rf /tmp/*
rm -rf /var/tmp/*
find /home -type d -name 'tmp' -exec rm -rf {}/* \; 2>/dev/null


# 7. Remove old config backup files
echo -e "${GREEN}>>> Removing old config backup files...${NC}"
find /home -name "*~" -delete
find /etc -name "*~" -delete

# 8. Clean AUR build files (if yay is installed)
if command -v yay &> /dev/null; then
    echo -e "${GREEN}>>> Cleaning AUR build files...${NC}"
    yay -Yc --noconfirm
else
    echo "yay not installed, skipping AUR cleanup."
fi

# 9. Remove broken symlinks
echo -e "${GREEN}>>> Removing broken symlinks...${NC}"
find / -xtype l -delete 2>/dev/null

# 10. Remove old kernels (keep current and one previous)
echo -e "${GREEN}>>> Removing old kernels...${NC}"
current_kernel=$(uname -r)
all_kernels=$(pacman -Q linux | cut -d' ' -f1 | grep -v "$current_kernel")
# Keep the most recent previous kernel
previous_kernel=$(pacman -Q linux | sort -V | tail -2 | head -1 | cut -d' ' -f1)
kernels_to_remove=$(echo "$all_kernels" | grep -v "$previous_kernel")

if [ -z "$kernels_to_remove" ]; then
    echo "No old kernels to remove."
else
    echo "The following old kernels will be removed:"
    echo "$kernels_to_remove"
    pacman -Rns --noconfirm $kernels_to_remove
fi

echo -e "${GREEN}>>> Cleanup complete!${NC}"
echo "You may want to reboot if you removed old kernels."
