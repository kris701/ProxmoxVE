#!/usr/bin/env bash

# Copyright (c) 2021-2025 community-scripts ORG
# Author: Kristian Skov
# License: MIT | https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE

source /dev/stdin <<< "$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
#update_os

msg_info "Installing Dependencies"
$STD apt-get install -y \
  curl \
  gnupg \
  coreutils
msg_ok "Installed Dependencies"

msg_info "Installing UrBackup Server"
echo 'deb http://download.opensuse.org/repositories/home:/uroni/xUbuntu_24.04/ /' | tee /etc/apt/sources.list.d/home:uroni.list
curl -fsSL https://download.opensuse.org/repositories/home:uroni/xUbuntu_24.04/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/home_uroni.gpg > /dev/null
$STD apt update -y
$STD apt install -y urbackup-server
msg_ok "UrBackup Server Installed"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"
