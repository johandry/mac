#!/bin/bash

declare -r SETUP_DIR="$( cd "$( dirname "$0" )" && pwd )"
source "${SETUP_DIR}/files/common.sh"
source "${SETUP_DIR}/functions.sh"

echo
echo "Directories and files"
echo

create_dir 'Workspace & Sandbox' "$HOME/Workspace/Sandbox"
create_dir 'Local bin' "$HOME/bin"

copy_file 'Common script' "${SETUP_DIR}/files/common.sh" "$HOME/bin/common.sh"

echo
echo "App Store Installs"
echo

install_app_store 'XCode' 			'/Applications/Xcode.app/Contents/MacOS/Xcode' 'itunes.apple.com/us/app/xcode/id497799835?mt=12' 'echo "Accept XCode License" && open /Applications/Xcode.app'
install_app_store '1Password' 	'/Applications/1Password.app/Contents/MacOS/1Password' 'itunes.apple.com/us/app/1password-password-manager/id443987910?mt=12'
install_app_store 'iMovie' 			'/Applications/iMovie.app/Contents/MacOS/iMovie' 'itunes.apple.com/us/app/imovie/id408981434?mt=12'
install_app_store 'Keynote' 		'/Applications/Keynote.app/Contents/MacOS/Keynote' 'itunes.apple.com/us/app/keynote/id409183694?mt=12'
install_app_store 'Numbers' 		'/Applications/Numbers.app/Contents/MacOS/Numbers' 'itunes.apple.com/us/app/numbers/id409203825?mt=12'
install_app_store 'Pages' 			'/Applications/Pages.app/Contents/MacOS/Pages' 'itunes.apple.com/us/app/pages/id409201541?mt=12'
install_app_store 'MindNode 2' 	'/Applications/MindNode.app/Contents/MacOS/MindNode' 'itunes.apple.com/us/app/mindnode-2-delightful-mind/id992076693?mt=12'
install_app_store 'Twitter' 		'/Applications/Twitter.app/Contents/MacOS/Twitter' 'itunes.apple.com/us/app/twitter/id409789998?mt=12'
install_app_store 'OneDrive'    '/Applications/OneDrive.app/Contents/MacOS/OneDrive' 'itunes.apple.com/us/app/onedrive/id823766827?mt=12' 'echo "Configure OneDrive" && open /Applications/OneDrive.app'

echo
echo "Applications"
echo

install 'Homebrew' 					'/usr/local/bin/brew' 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
install 'Wget' 							'/usr/local/bin/wget' 'brew install wget'
install 'Brew Cask' 				'/usr/local/bin/brew-cask' 'brew install caskroom/cask/brew-cask'
install 'Oh-My-Zsh'         "$HOME/.oh-my-zsh/oh-my-zsh.sh" 'curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh'

create_dir 'Oh-My-Zsh Custom Themes Directory' "$HOME/.oh-my-zsh/custom/themes"
copy_file 'Oh-My-Zsh Custom Theme ' "${SETUP_DIR}/files/af-magic-clean.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/af-magic-clean.zsh-theme"

# Cloud Storage
install 'Dropbox'           "$HOME/Applications/Dropbox.app/Contents/MacOS/Dropbox" 'brew-cask install dropbox'
install 'Box Sync'          "$HOME/Applications/Box Sync.app/Contents/MacOS/Box Sync" 'brew-cask install box-sync'        
# DevOps Tools
install 'Virtual Box'       "/Applications/VirtualBox.app/Contents/MacOS/virtualbox" 'brew-cask install virtualbox'
install 'Vagrant'           "/usr/local/bin/vagrant" 'brew-cask install vagrant'
install 'Packer'            "/usr/local/bin/packer" 'brew-cask install packer'
install 'Docker Tool Box'   "/Applications/Docker/Kitematic (Beta).app/Contents/MacOS/Electron" 'brew-cask install dockertoolbox'
install 'GitHub Desktop'    '/usr/local/bin/github' 'brew-cask install github-desktop'
install 'MacDown'           "$HOME/Applications/MacDown.app/Contents/MacOS/MacDown" 'brew-cask install macdown'
# Browsers
install 'Firefox'           "$HOME/Applications/Firefox.app/Contents/MacOS/firefox" 'brew-cask install firefox'
install 'TorBrowser'        "$HOME/Applications/TorBrowser.app/Contents/MacOS/firefox" 'brew-cask install torbrowser'
# Movies
install 'VLC'               "$HOME/Applications/VLC.app/Contents/MacOS/VLC" 'brew-cask install vlc'
# Music
install 'Spotify'           "$HOME/Applications/Spotify.app/Contents/MacOS/Spotify" 'brew-cask install spotify'
# Chat
install 'Skype'             "$HOME/Applications/Skype.app/Contents/MacOS/Skype" 'brew-cask install skype'
install 'Colloquy'          "$HOME/Applications/Colloquy.app/Contents/MacOS/Colloquy" 'brew-cask install colloquy'
# File Management
install 'Transmission'      "$HOME/Applications/Transmission.app/Contents/MacOS/Transmission" 'brew-cask install transmission'
install 'UnRarX'            "$HOME/Applications/UnRarX.app/Contents/MacOS/UnRarX" 'brew-cask install unrarx'
# Miscellaneous 
install 'Caffeine'          "$HOME/Applications/Caffeine.app/Contents/MacOS/Caffeine" 'brew-cask install caffeine'
install 'Spectacle'         "$HOME/Applications/Spectacle.app/Contents/MacOS/Spectacle" 'brew-cask install spectacle'

# Applications to think about:
# install 'Google Drive'
# install 'Microsoft Silverlight'
# install 'Visual Studio Code'
# install 'iChm'
# install 'Art Text 2'
# install 'SQLPro for SQLite'
# install 'VoiceZoneConnect'

echo
echo "Manual Installs"
echo

install_sublime_text_3
install_google_chrome