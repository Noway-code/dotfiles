#!/bin/bash

# Colors for the text
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to display a progress spinner
spinner() {
    local pid=$!
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Print welcome message with ASCII art
echo -e "${CYAN}"
echo "==========================================="
echo "           Updating System!                "
echo "==========================================="
echo -e "${NC}"

# Cleaning up dpkg locks
echo -e "${YELLOW}Cleaning up dpkg locks...${NC}"
sudo rm -rf /var/lib/dpkg/lock-frontend /var/lib/dpkg/lock & spinner
echo -e "${GREEN}Cleaned up dpkg locks.${NC}"

# Updating package list
echo -e "${YELLOW}Updating package list...${NC}"
sudo apt-get update & spinner
echo -e "${GREEN}Package list updated.${NC}"

# Upgrading installed packages
echo -e "${YELLOW}Upgrading installed packages...${NC}"
sudo apt-get upgrade -y & spinner
echo -e "${GREEN}Packages upgraded.${NC}"

# Performing full-upgrade
echo -e "${YELLOW}Performing full-upgrade...${NC}"
sudo apt-get full-upgrade -y & spinner
echo -e "${GREEN}System fully upgraded.${NC}"

# Removing unnecessary packages
echo -e "${YELLOW}Removing unnecessary packages...${NC}"
sudo apt-get autoremove -y & spinner
sudo apt-get clean & spinner
sudo apt-get autoclean -y & spinner
echo -e "${GREEN}Unused packages removed.${NC}"

# Checking if reboot is required
if [ -f /var/run/reboot-required ]; then
    echo -e "${RED}Reboot is required! Please reboot your system.${NC}"
    sleep 1
fi

# Final message
echo -e "${BLUE}"
echo "==========================================="
echo "         System Update Completed!          "
echo "==========================================="
echo -e "${NC}"

# Close the terminal after the script finishes
sleep 1
exit
