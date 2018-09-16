#!/bin/bash

VERSION='1.5.0'
TITLE='Mac Provisioner'
PROJECT="OSX_Setup"
SOURCE_DIR=

APPLE_ID=johandry@icloud.com
DOCK_SIZE=40
ZSH_THEME=af-magic-clean

CURL="curl -fsL"
URL="http://www.johandry.com/mac"

#=======================================================================================================
# Author: Johandry Amador <johandry@gmail.com>
# Title:  {title}
# Version: {version}
#
# Usage: {script_name} [-h | configuration]
#
# Options:
#     -h, --help    Display this help message. bash {script_name} -h
#     configuration Configuration to load to provisioning this Mac. If not provided will use the hostname
#
# Description: {title} is to provisioning or install a applications in a Mac. The applications to install are in configuration files.
#              When there is a new application, it has to be added in config.sh then in the configuration file where it will be installed.
#
# Report Issues or create Pull Requests in http://github.com/johandry/{project_name}
#=======================================================================================================

[[ ! -e "$HOME/bin/common.sh" ]] && \
  echo "~/bin/common.sh was not found, I'm installing it ..." && \
  curl -s http://cs.johandry.com/install | bash

[[ ! -e "$HOME/bin/common.sh" ]] && \
  echo "~/bin/common.sh was not found, install it manually from: http://cs.johandry.com/install " && \
  exit 1

source ~/bin/common.sh

# Set LOCAL_SETUP=1 to make 'setup.sh' use local files instead of gettting them from GitHub
if [[ "${LOCAL_SETUP}" == "1" ]]; then
  CURL="cat"
  URL="${SCRIPT_DIR}"
fi

info "Installing Homebrew, Homebrew Bundle"
[[ -z "$(command -v brew)" ]] && \
  /usr/bin/ruby -e "$(${CURL} https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap Homebrew/bundle

if [[ $? -ne 0 ]]; then
  error "Apple Store sign in failed. Try with command: mas signin ${APPLE_ID}"
  exit 2
fi

info "Creating Brewfile"
$CURL $URL/Brewfile.Common > Brewfile

brewfiles="$@"
[[ -z $brewfiles ]] && brewfiles=$(uname -n)

for f in $brewfiles; do
  if $CURL $URL/Brewfile.$f >> Brewfile; then 
    info "  * Appending Brewfile.$f"
  else 
    warn "  * Not found Brewfile.$f"
  fi
done

info "Brewing all the applications"
brew bundle install --verbose

mv Brewfile ~/.Brewfile

if [[ -e /usr/local/bin/code || -e /Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron ]]; then
  info "Installing Visual Studio Extensions"
  for ext in $($CURL $URL/VSCode_Extensions.lst | grep -v '^#' | grep -v '^$'); do
    code --install-extension ${ext}
  done
fi

if [[ -e /usr/local/bin/atom || -e /Applications/Atom.app/Contents/MacOS/Atom ]]; then
  info "Installing Atom packages"
  for pkg in $($CURL $URL/Atom_Packages.lst); do
    [[ ! -d ${HOME}/.atom/packages/${pkg} ]] && apm install ${pkg}
  done
fi

info "Resizing Dock"
currentSize=$(defaults read com.apple.dock tilesize 2>/dev/null)
[[ ${currentSize} -ne ${DOCK_SIZE} ]] && defaults write com.apple.dock tilesize -int ${DOCK_SIZE} && killall Dock

# info "Setting Trackpad Tap to Click"
# currentClicking=$(defaults read com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking)
#   [[ ${currentClicking} -ne 1 ]] && defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# currentTapBehaviour=$(defaults -currentHost read NSGlobalDomain com.apple.mouse.tapBehavior)
# if [[ ${currentTapBehaviour} -ne 1 ]]; then
#   defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
#   defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# fi
# currentRightClick=$(defaults read com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true)
# if [[ ${currentRightClick} -ne 1 ]]; then
#   defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
#   defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
# fi
# currentSecondaryClick=$(defaults -currentHost read NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true)
# if [[ ${currentSecondaryClick} -ne 1 ]]; then
#   defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
#   defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
# fi
# currentRightClick2=$(defaults read com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true)
# if [[ ${currentRightClick2} -ne 1 ]]; then
#   defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
#   defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
# fi


info "Creating Directories"
mkdir -p ${HOME}/Workspace/go/{bin,pkg,src/github.com/johandry,Sandbox}
mkdir -p ${HOME}/bin
ln -s ${HOME}/Workspace/src/github.com/johandry ${HOME}/Workspace

info "Setting up Zsh"
[[ ! -e "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]] && \
  $CURL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

mkdir -p $HOME/.oh-my-zsh/custom/themes
$CURL $URL/files/${ZSH_THEME}.zsh-theme > ${HOME}/.oh-my-zsh/custom/themes/${ZSH_THEME}.zsh-theme

theme="ZSH_THEME=\"${ZSH_THEME}\""
grep -q ${theme} ${HOME}/.zshrc || sed -i.bak "s/^ZSH_THEME=\".*\"$/${theme}/" ${HOME}/.zshrc

plugins='plugins=(git github osx python pip sudo go brew brew-cask colorize common-aliases docker docker-compose emoji emoji-clock vagrant aws ng npm zsh-completions kubectl)'
grep -q "${plugins}" ${HOME}/.zshrc || sed -i.bak "s/^plugins=(.*)$/${plugins}/" ${HOME}/.zshrc

if ! grep -q '# DO NOT REMOVE: Personal ZSH settings' ${HOME}/.zshrc; then 
  $CURL $URL/files/zsh.config >> ${HOME}/.zshrc
fi

rm -f $HOME/.zshrc.bak

info "Setting up Bash"

[[ ! -e $HOME/.bash_profile ]] && touch $HOME/.bash_profile
if ! grep -q '# DO NOT REMOVE: Personal Bash settings' ${HOME}/.bash_profile; then 
  $CURL $URL/files/bash.config >> ${HOME}/.bash_profile
fi