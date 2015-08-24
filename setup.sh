#!/bin/bash

declare -r SETUP_DIR="$( cd "$( dirname "$0" )" && pwd )"
source "${SETUP_DIR}/common.sh"

check_app(){
  app=$1
  file=$2

  print_msg="echo -e ${app}\t\t[OK]"
  [[ "$3" == "--quiet" ]] && print_msg=""

  [[ -e ${file} ]] && ${print_msg}  && return 0
  return 1
}

install() {
  app=$1
  file=$2
  install=$3


  check_app "${app}" "${file}" --quiet
  if [[ $? -eq 1 ]]
    then
    echo "Installing ${app}"
    eval "${install}"
  fi

  check_app "${app}" "${file}" 
  [[ $? -eq 1 ]] && echo -e "${app}\t\t[ERROR]" && return 1
  return 0
}

install_app_store() {
	app=$1
	file=$2
	url=$3
	post_action=$4

	check_app "${app}" "${file}" --quiet
	if [[ $? -eq 1 ]]
		then
		echo "Install ${app}"
		open macappstore://${url}
		read -p "Press [Enter] key when it is ready ..."
		[[ -n "${post_action}" ]] && eval "${post_action}"
	fi
	check_app "${app}" "${file}"
}

create_dir() {
	name=$1
	dir=$2

	[[ ! -d "${dir}" ]] && mkdir -p "${dir}"
	[[   -d "${dir}" ]] && echo -e "$name\t\t[OK]" || echo -e "$name\t\t[ERROR]"
}

copy_file() {
	name=$1
	file=$2
	dest=$3

	[[ ! -e "${dest}" ]] && cp "${file}" "${dest}"
	[[   -e "${dest}" ]] && echo -e "${name}\t\t[OK]" || echo -e "${name}\t\t[ERROR]"
}

echo
echo "Directories and files"
echo

create_dir 'Workspace & Sandbox' "$HOME/Workspace/Sandbox"
create_dir 'Local bin' "$HOME/bin"

copy_file 'Common script' "${SETUP_DIR}/common.sh" "$HOME/bin/common.sh"

echo
echo "App Store Installs"
echo

install_app_store 'XCode' '/Applications/Xcode.app/Contents/MacOS/Xcode' 'itunes.apple.com/us/app/xcode/id497799835?mt=12' 'echo "Accept XCode License" && open /Applications/Xcode.app'
install_app_store 'OS X Server' '/Applications/Server.app/Contents/MacOS/Server' 'itunes.apple.com/us/app/os-x-server/id883878097?mt=12' 'echo "Configure OS X Server" && open /Applications/Server.app'
install_app_store '1Password' '/Applications/1Password.app/Contents/MacOS/1Password' 'itunes.apple.com/us/app/1password-password-manager/id443987910?mt=12'
install_app_store 'GarageBand' '/Applications/GarageBand.app/Contents/MacOS/GarageBand' 'itunes.apple.com/us/app/garageband/id682658836?mt=12'
install_app_store 'iMovie' '/Applications/iMovie.app/Contents/MacOS/iMovie' 'itunes.apple.com/us/app/imovie/id408981434?mt=12'
install_app_store 'Keynote' '/Applications/Keynote.app/Contents/MacOS/Keynote' 'itunes.apple.com/us/app/keynote/id409183694?mt=12'
install_app_store 'Numbers' '/Applications/Numbers.app/Contents/MacOS/Numbers' 'itunes.apple.com/us/app/numbers/id409203825?mt=12'
install_app_store 'Pages' '/Applications/Pages.app/Contents/MacOS/Pages' 'itunes.apple.com/us/app/pages/id409201541?mt=12'
install_app_store 'SourceTree' '/Applications/SourceTree.app/Contents/MacOS/SourceTree' 'itunes.apple.com/us/app/sourcetree-git-hg/id411678673?mt=12'
install_app_store 'HP Easy Scan' '/Applications/HP Easy Scan.app/Contents/MacOS/HP Easy Scan' 'itunes.apple.com/us/app/hp-easy-scan/id967004861?mt=12'
install_app_store 'MindNode 2' '/Applications/MindNode.app/Contents/MacOS/MindNode' 'itunes.apple.com/us/app/mindnode-2-delightful-mind/id992076693?mt=12'
install_app_store 'Twitter' '/Applications/Twitter.app/Contents/MacOS/Twitter' 'itunes.apple.com/us/app/twitter/id409789998?mt=12'

echo
echo "Applications"
echo

install 'Homebrew' '/usr/local/bin/brew' 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
install 'Wget' '/usr/local/bin/wget' 'brew install wget'
install 'Brew Cask' '/usr/local/bin/brew-cask' 'brew install caskroom/cask/brew-cask'
install 'Dropbox' "$HOME/Applications/Dropbox.app/Contents/MacOS/Dropbox" 'brew-cask install dropbox'
install 'Box Sync' "$HOME/Applications/Box Sync.app/Contents/MacOS/Box Sync" 'brew-cask install box-sync'

echo
echo "Manual Installs"
echo

check_app 'Sublime Text 3' '/usr/bin/subl' --quiet
if [[ $? -eq 1 ]]
  then
  echo "Download and install latest version of Sublime Text 3 (http://www.sublimetext.com/3)"
  echo "Cannot be installed with Brew because there is only version 2"
  open "http://www.sublimetext.com/3"
  read -p "Press [Enter] key when it is ready ..."
  sudo ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/bin/subl
fi
check_app 'Sublime Text 3' '/usr/bin/subl'

check_app 'Google Chrome' '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' --quiet
if [[ $? -eq 1 ]]
  then
  echo "Download and install latest version of Google Chrome (http://www.google.com/chrome/)"
  echo "Cannot be installed with Brew because Chrome is always notifying to upgrade"
  open "http://www.google.com/chrome/"
  read -p "Press [Enter] key when it is ready ..."
fi
check_app 'Google Chrome' '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'


