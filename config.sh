#!/bin/bash

# App Store 
XCode=(       app_store 'XCode'       '/Applications/Xcode.app/Contents/MacOS/Xcode'            'itunes.apple.com/us/app/xcode/id497799835?mt=12'                 'echo "Accept XCode License" && open /Applications/Xcode.app' )
OS_X_Server=( app_store 'OS X Server' '/Applications/Server.app/Contents/MacOS/Server'          'itunes.apple.com/us/app/os-x-server/id883878097?mt=12'           'echo "Configure OS X Server" && open /Applications/Server.app' )
OnePassword=( app_store '1Password'   '/Applications/1Password.app/Contents/MacOS/1Password'    'itunes.apple.com/us/app/1password-password-manager/id443987910?mt=12' )
GarageBand=(  app_store 'GarageBand'  '/Applications/GarageBand.app/Contents/MacOS/GarageBand'  'itunes.apple.com/us/app/garageband/id682658836?mt=12' )
iMovie=(      app_store 'iMovie'      '/Applications/iMovie.app/Contents/MacOS/iMovie'          'itunes.apple.com/us/app/imovie/id408981434?mt=12' )
Keynote=(     app_store 'Keynote'     '/Applications/Keynote.app/Contents/MacOS/Keynote'        'itunes.apple.com/us/app/keynote/id409183694?mt=12' )
Numbers=(     app_store 'Numbers'     '/Applications/Numbers.app/Contents/MacOS/Numbers'        'itunes.apple.com/us/app/numbers/id409203825?mt=12' )
Pages=(       app_store 'Pages'       '/Applications/Pages.app/Contents/MacOS/Pages'            'itunes.apple.com/us/app/pages/id409201541?mt=12' )
HP_Easy_Scan=(app_store 'HP Easy Scan' '/Applications/HP Easy Scan.app/Contents/MacOS/HP Easy Scan' 'itunes.apple.com/us/app/hp-easy-scan/id967004861?mt=12' )
MindNode_2=(  app_store 'MindNode 2'  '/Applications/MindNode.app/Contents/MacOS/MindNode'      'itunes.apple.com/us/app/mindnode-2-delightful-mind/id992076693?mt=12' )
Twitter=(     app_store 'Twitter'     '/Applications/Twitter.app/Contents/MacOS/Twitter'        'itunes.apple.com/us/app/twitter/id409789998?mt=12' )
OneDrive=(    app_store 'OneDrive'    '/Applications/OneDrive.app/Contents/MacOS/OneDrive'      'itunes.apple.com/us/app/onedrive/id823766827?mt=12'              'echo "Configure OneDrive" && open /Applications/OneDrive.app' )
Money=(       app_store 'Money'       '/Applications/Money.app/Contents/MacOS/Money'            'itunes.apple.com/us/app/money-by-jumsoft/id402410845?mt=12' )

# Core
Homebrew=(    cmd 'Homebrew'          '/usr/local/bin/brew' 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"' )
Wget=(        cmd 'Wget'              '/usr/local/bin/wget' 'brew install wget' )
Brew_Cask=(   cmd 'Brew Cask'         '/usr/local/bin/brew-cask' 'brew install caskroom/cask/brew-cask' )
Oh_My_Zsh=(   cmd 'Oh-My-Zsh'         "$HOME/.oh-my-zsh/oh-my-zsh.sh" 'curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh' )

# Cloud Storage
Dropbox=(     cmd 'Dropbox'           "$HOME/Applications/Dropbox.app/Contents/MacOS/Dropbox" 'brew-cask install dropbox' )
Box_Sync=(    cmd 'Box Sync'          "$HOME/Applications/Box Sync.app/Contents/MacOS/Box Sync" 'brew-cask install box-sync' )
# DevOps Tools
Virtual_Box=( cmd 'Virtual Box'       "/Applications/VirtualBox.app/Contents/MacOS/virtualbox" 'brew-cask install virtualbox' )
Vagrant=(     cmd 'Vagrant'           "/usr/local/bin/vagrant" 'brew-cask install vagrant' )
Packer=(      cmd 'Packer'            "/usr/local/bin/packer" 'brew-cask install packer' )
Docker_Tool_Box=( cmd 'Docker Tool Box'   "/Applications/Docker/Kitematic (Beta).app/Contents/MacOS/Electron" 'brew-cask install dockertoolbox' )
GitHub_Desktop=(  cmd 'GitHub Desktop'    '/usr/local/bin/github' 'brew-cask install github-desktop' )
MacDown=(     cmd 'MacDown'           "$HOME/Applications/MacDown.app/Contents/MacOS/MacDown" 'brew-cask install macdown' )
# Browsers
Firefox=(     cmd 'Firefox'           "$HOME/Applications/Firefox.app/Contents/MacOS/firefox" 'brew-cask install firefox' )
TorBrowser=(  cmd 'TorBrowser'        "$HOME/Applications/TorBrowser.app/Contents/MacOS/firefox" 'brew-cask install torbrowser' )
# Movies
HandBrake=(   cmd 'HandBrake'         "$HOME/Applications/HandBrake.app/Contents/MacOS/HandBrake" 'brew-cask install handbrake' )
HandBrake_CLI=(cmd 'HandBrake CLI'     '/usr/local/bin/HandBrakeCLI' 'brew-cask install handbrakecli' )
Subler=(      cmd 'Subler'            "$HOME/Applications/Subler.app/Contents/MacOS/Subler" 'brew-cask install subler' )
Subler_CLI=(  cmd 'Subler CLI'        '/usr/local/bin/SublerCLI' 'brew-cask install sublercli' )
VLC=(         cmd 'VLC'               "$HOME/Applications/VLC.app/Contents/MacOS/VLC" 'brew-cask install vlc' )
MakeMKV=(     cmd 'MakeMKV'           "$HOME/Applications/MakeMKV.app/Contents/MacOS/makemkv" 'brew-cask install makemkv' )
MKV_Tools=(   cmd 'MKV Tools'         "$HOME/Applications/MKVtools.app/Contents/MacOS/MKVtools" 'brew-cask install mkvtools' )
# Music
Spotify=(     cmd 'Spotify'           "$HOME/Applications/Spotify.app/Contents/MacOS/Spotify" 'brew-cask install spotify' )
# Chat
Colloquy=(    cmd 'Colloquy'          "$HOME/Applications/Colloquy.app/Contents/MacOS/Colloquy" 'brew-cask install colloquy' )
Skype=(       cmd 'Skype'             "$HOME/Applications/Skype.app/Contents/MacOS/Skype" 'brew-cask install skype' )
# File Management
Transmission=(cmd 'Transmission'      "$HOME/Applications/Transmission.app/Contents/MacOS/Transmission" 'brew-cask install transmission' )
UnRarX=(      cmd 'UnRarX'            "$HOME/Applications/UnRarX.app/Contents/MacOS/UnRarX" 'brew-cask install unrarx' )
# Miscellaneous 
Caffeine=(    cmd 'Caffeine'          "$HOME/Applications/Caffeine.app/Contents/MacOS/Caffeine" 'brew-cask install caffeine' )
Spectacle=(   cmd 'Spectacle'         "$HOME/Applications/Spectacle.app/Contents/MacOS/Spectacle" 'brew-cask install spectacle' )

# Applications to think about:
# install Google Drive
# install Microsoft Silverlight
# install NETGEARGenie
# install PAC-MAN
# install Scratch 2
# install Visual Studio Code
# install iChm
# install Aperture
# install Art Text 2
# install Mint QuickView
# install PyCharm CE
# install RubyMine
# install SQLPro for SQLite
# install VoiceZoneConnect
# install WebStorm

# SourceTree is not longer up to date in App Store. Installing with Brew-Cask
# SourceTree=(  app_store 'SourceTree' '/Applications/SourceTree.app/Contents/MacOS/SourceTree' 'itunes.apple.com/us/app/sourcetree-git-hg/id411678673?mt=12'
# GitHub Desktop better than SourceTree
# install SourceTree' '/usr/local/bin/stree' 'brew-cask install sourcetree


