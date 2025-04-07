#!/bin/bash

# Create a swap file
sudo dd if=/dev/zero of=/swapfile bs=1M count=3072

# Set appropriate permissions
sudo chmod 600 /swapfile

# Set up the swap area
sudo mkswap /swapfile

# Activate the swap space
sudo swapon /swapfile

# Add swap file to /etc/fstab for persistence
echo '/swapfile swap swap defaults 0 0' | sudo tee -a /etc/fstab

# Verify swap is active
sudo swapon --show

# Adjust Swappiness to 100
echo 'vm.swappiness=100' | sudo tee -a /etc/sysctl.conf

# Disable Transparent Huge Pages (THP)
echo never | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
echo 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' | sudo tee -a /etc/rc.local

# Disable unnecessary services
sudo systemctl disable --now firewalld
sudo systemctl disable --now postfix

# Reboot the server
#sudo reboot

