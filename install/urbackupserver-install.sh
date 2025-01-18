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
$STD apt-get update
msg_ok "Installed Dependencies"

msg_info "Installing UrBackup Server"
wget https://hndl.urbackup.org/Server/2.5.33/urbackup-server_2.5.33_amd64.deb
dpkg -i urbackup-server_2.5.33_amd64.deb
$STD apt install -f
msg_ok "UrBackup Server Installed"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"
