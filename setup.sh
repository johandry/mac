#!/bin/bash

check_app(){
  app=$1
  check=$2

  print_msg="echo -e ${app}\t\t[OK]"
  [[ "$3" == "--quiet" ]] && print_msg=""

  eval "${check}" &>/dev/null
  [[ $? -eq 0 ]] && ${print_msg}  && return 0
  return 1
}

install() {
  app=$1
  check=$2
  install=$3


  check_app "${app}" "${check}" --quiet
  if [[ $? -eq 1 ]]
  then
    echo "Installing ${app}"
    eval "${install}"
  fi

  check_app "${app}" "${check}" 
  [[ $? -eq 1 ]] && echo -e "${app}\t\t[ERROR]" && return 1
  return 0
}

echo "Applications"
echo

install 'Homebrew' 'brew -v' 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
install 'Wget' 'wget --version' 'brew install wget'
install 'Brew Cask' 'brew-cask --version' 'brew install caskroom/cask/brew-cask'
install 'Dropbox' '! brew-cask info dropbox | grep -q "Not installed"' 'brew-cask install dropbox'
install 'Box Sync' '! brew-cask info box-sync | grep -q "Not installed"' 'brew-cask install box-sync'

echo
echo "Directories"
echo

[[ ! -d ~/Workspace/Sandbox ]] && mkdir -p ~/Workspace/Sandbox
[[   -d ~/Workspace/Sandbox ]] && echo -e "Workspace & Sandbox\t\t[OK]"

[[ ! -d ~/bin ]] && mkdir ~/bin
[[   -d ~/bin ]] && echo -e "Local bin\t\t[OK]"
