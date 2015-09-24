#!/bin/bash

#=======================================================================================================
# Author: Johandry Amador <johandry@gmail.com>
# Title: My Mac provisioning 
#
# Usage: {script_name} [-h | configuration]
#
# Options:
#     -h, --help    Display this help message. bash {script_name} -h
#     configuration Configuration to load to provisioning this Mac. If not provided will use the hostname
#
# Description: This script is to provisioning or install a applications in a Mac. The applications to install are in configuration files. 
#              When there is a new application, it has to be added in config.sh then in the configuration file where it will be installed.
#
# Report Issues or create Pull Requests in http://github.com/johandry/
#=======================================================================================================


declare -r SETUP_DIR="$( cd "$( dirname "$0" )" && pwd )"
source "${SETUP_DIR}/files/common.sh"
source "${SETUP_DIR}/functions.sh"
source "${SETUP_DIR}/config.sh"  

if [[ -z $1 ]]
  then
  if [[ -e "${SETUP_DIR}/$HOSTNAME.cnf" ]]
    then
    info "Loading $HOSTNAME.cnf configuration"
    source "${SETUP_DIR}/$HOSTNAME.cnf" 
  else
    error "The configuration file for this host ($HOSTNAME) was not found. Provide a configuration file to load."
    exit 1
  fi
else
  if [[ -e "${SETUP_DIR}/$1.cnf"  ]]
    then 
    info "Loading $1.cnf configuration"
    source "${SETUP_DIR}/$1.cnf" 
  else
    error "Configuration file for $1 was not found. Enter a valid configuration ($(ls ${SETUP_DIR}/*.cnf | sed 's/\(.*\)\.cnf/\1/' | tr '\n' ',' | sed 's/,/, /'))"
    exit 1
  fi
fi


echo
echo "Directories and files"
echo

create_dir 'Workspace & Sandbox' "$HOME/Workspace/Sandbox"
create_dir 'Local bin' "$HOME/bin"

copy_file 'Common script' "${SETUP_DIR}/files/common.sh" "$HOME/bin/common.sh"

echo
echo "Applications"
echo

for app in ${applications[@]}
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