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

install_app_store 'XCode'       '/Applications/Xcode.app/Contents/MacOS/Xcode' 'itunes.apple.com/us/app/xcode/id497799835?mt=12' 'echo "Accept XCode License" && open /Applications/Xcode.app'
install_app_store 'OS X Server' '/Applications/Server.app/Contents/MacOS/Server' 'itunes.apple.com/us/app/os-x-server/id883878097?mt=12' 'echo "Configure OS X Server" && open /Applications/Server.app'
install_app_store '1Password'   '/Applications/1Password.app/Contents/MacOS/1Password' 'itunes.apple.com/us/app/1password-password-manager/id443987910?mt=12'
install_app_store 'GarageBand'  '/Applications/GarageBand.app/Contents/MacOS/GarageBand' 'itunes.apple.com/us/app/garageband/id682658836?mt=12'
install_app_store 'iMovie'      '/Applications/iMovie.app/Contents/MacOS/iMovie' 'itunes.apple.com/us/app/imovie/id408981434?mt=12'
install_app_store 'Keynote'     '/Applications/Keynote.app/Contents/MacOS/Keynote' 'itunes.apple.com/us/app/keynote/id409183694?mt=12'
install_app_store 'Numbers'     '/Applications/Numbers.app/Contents/MacOS/Numbers' 'itunes.apple.com/us/app/numbers/id409203825?mt=12'
install_app_store 'Pages'       '/Applications/Pages.app/Contents/MacOS/Pages' 'itunes.apple.com/us/app/pages/id409201541?mt=12'
install_app_store 'HP Easy Scan' '/Applications/HP Easy Scan.app/Contents/MacOS/HP Easy Scan' 'itunes.apple.com/us/app/hp-easy-scan/id967004861?mt=12'
install_app_store 'MindNode 2'  '/Applications/MindNode.app/Contents/MacOS/MindNode' 'itunes.apple.com/us/app/mindnode-2-delightful-mind/id992076693?mt=12'
install_app_store 'Twitter'     '/Applications/Twitter.app/Contents/MacOS/Twitter' 'itunes.apple.com/us/app/twitter/id409789998?mt=12'
install_app_store 'OneDrive'    '/Applications/OneDrive.app/Contents/MacOS/OneDrive' 'itunes.apple.com/us/app/onedrive/id823766827?mt=12' 'echo "Configure OneDrive" && open /Applications/OneDrive.app'
install_app_store 'Money'       '/Applications/Money.app/Contents/MacOS/Money' 'itunes.apple.com/us/app/money-by-jumsoft/id402410845?mt=12'
# SourceTree is not longer up to date in App Store. Installing with Brew-Cask
#install_app_store 'SourceTree' '/Applications/SourceTree.app/Contents/MacOS/SourceTree' 'itunes.apple.com/us/app/sourcetree-git-hg/id411678673?mt=12'

echo
echo "Applications"
echo

# Core
install 'Homebrew'          '/usr/local/bin/brew' 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
install 'Wget'              '/usr/local/bin/wget' 'brew install wget'
install 'Brew Cask'         '/usr/local/bin/brew-cask' 'brew install caskroom/cask/brew-cask'
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
# Browsers
install 'Firefox'           "$HOME/Applications/Firefox.app/Contents/MacOS/firefox" 'brew-cask install firefox'
install 'TorBrowser'        "$HOME/Applications/TorBrowser.app/Contents/MacOS/firefox" 'brew-cask install torbrowser'
# Movies
install 'HandBrake'         "$HOME/Applications/HandBrake.app/Contents/MacOS/HandBrake" 'brew-cask install handbrake'
install 'HandBrake CLI'     '/usr/local/bin/HandBrakeCLI' 'brew-cask install handbrakecli'
install 'Subler'            "$HOME/Applications/Subler.app/Contents/MacOS/Subler" 'brew-cask install subler'
install 'Subler CLI'        '/usr/local/bin/SublerCLI' 'brew-cask install sublercli'
install 'VLC'               "$HOME/Applications/VLC.app/Contents/MacOS/VLC" 'brew-cask install vlc'
install 'MakeMKV'           "$HOME/Applications/MakeMKV.app/Contents/MacOS/makemkv" 'brew-cask install makemkv'
install 'MKV Tools'         "$HOME/Applications/MKVtools.app/Contents/MacOS/MKVtools" 'brew-cask install mkvtools'
# Music
install 'Spotify'           "$HOME/Applications/Spotify.app/Contents/MacOS/Spotify" 'brew-cask install spotify'
# Chat
install 'Colloquy'          "$HOME/Applications/Colloquy.app/Contents/MacOS/Colloquy" 'brew-cask install colloquy'
install 'Skype'             "$HOME/Applications/Skype.app/Contents/MacOS/Skype" 'brew-cask install skype'
# File Management
install 'Transmission'      "$HOME/Applications/Transmission.app/Contents/MacOS/Transmission" 'brew-cask install transmission'
install 'UnRarX'            "$HOME/Applications/UnRarX.app/Contents/MacOS/UnRarX" 'brew-cask install unrarx'
# Miscellaneous 
install 'Caffeine'          "$HOME/Applications/Caffeine.app/Contents/MacOS/Caffeine" 'brew-cask install caffeine'
install 'Spectacle'         "$HOME/Applications/Spectacle.app/Contents/MacOS/Spectacle" 'brew-cask install spectacle'

# GitHub Desktop better than SourceTree
# install 'SourceTree' '/usr/local/bin/stree' 'brew-cask install sourcetree'

# Applications to think about:
# install 'Google Drive'
# install 'Microsoft Silverlight'
# install 'NETGEARGenie'
# install 'PAC-MAN'
# install 'Scratch 2'
# install 'Visual Studio Code'
# install 'iChm'
# install 'Aperture'
# install 'Art Text 2'
# install 'Mint QuickView'
# install 'PyCharm CE'
# install 'RubyMine'
# install 'SQLPro for SQLite'
# install 'VoiceZoneConnect'
# install 'WebStorm'

echo
echo "Manual Installs"
echo

install_sublime_text_3
install_google_chrome