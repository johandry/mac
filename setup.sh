#!/bin/bash

declare -r SETUP_DIR="$( cd "$( dirname "$0" )" && pwd )"
source "${SETUP_DIR}/files/common.sh"
source "${SETUP_DIR}/functions.sh"
source "${SETUP_DIR}/config.sh"  

declare -a personal=(
# Development
  XCode OS_X_Server 
# Office  
  Keynote Numbers Pages HP_Easy_Scan MindNode_2 Money
# Base
  Homebrew Wget Brew Cask Oh_My_Zsh
# Cloud Storage
  Dropbox Box_Sync OneDrive
# DevOps Tools
  Virtual_Box Vagrant Packer Docker_Tool_Box GitHub_Desktop MacDown
# Browsers
  Firefox TorBrowser
# Movies
  HandBrake HandBrake_CLI Subler Subler_CLI VLC MakeMKV MKV_Tools iMovie
# Music
  Spotify GarageBand
# Social
  Colloquy Skype Twitter
# File Management
  Transmission UnRarX
# Miscellaneous 
  Caffeine OnePassword
)

declare -a office=( 
# Development
  XCode 
# Office  
  Keynote Numbers Pages MindNode_2 Money
# Base
  Homebrew Wget Brew Cask Oh_My_Zsh
# Cloud Storage
  Dropbox Box_Sync OneDrive
# DevOps Tools
  Virtual_Box Vagrant Packer Docker_Tool_Box GitHub_Desktop MacDown
# Browsers
  Firefox TorBrowser
# Movies
  VLC
# Music
  Spotify
# Social
  Colloquy Skype Twitter
# File Management
  Transmission UnRarX
# Miscellaneous 
  Caffeine OnePassword
)

[[ -z $1 ]] && error "Missing parameter. Is this your personal or office Mac?" && exit 1
[[ $1 == "personal" ]] && applications="${personal[@]}"
[[ $1 == "office" ]]   && applications="${office[@]}"

echo
echo "Directories and files"
echo

create_dir 'Workspace & Sandbox' "$HOME/Workspace/Sandbox"
create_dir 'Local bin' "$HOME/bin"

copy_file 'Common script' "${SETUP_DIR}/files/common.sh" "$HOME/bin/common.sh"

echo
echo "Applications"
echo

for app in ${applications}
do
  install $app
done

create_dir 'Oh-My-Zsh Custom Themes Directory' "$HOME/.oh-my-zsh/custom/themes"
copy_file 'Oh-My-Zsh Custom Theme ' "${SETUP_DIR}/files/af-magic-clean.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/af-magic-clean.zsh-theme"


echo
echo "Manual Installs"
echo

install_sublime_text_3
install_google_chrome