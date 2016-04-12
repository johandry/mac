#!/bin/bash

VERSION='1.5.0'
TITLE='Mac Provisioner'
PROJECT="OSX_Setup"
SOURCE_DIR=

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
  echo "~/bin/common.sh not found, install it with: " && \
  echo "    curl -s http://cs.johandry.com/install | bash" && \
  exit 1

source ~/bin/common.sh

source "${SCRIPT_DIR}/functions.sh"
source "${SCRIPT_DIR}/config.sh"

if [[ -z $1 ]]
  then
  if [[ -e "${SCRIPT_DIR}/$HOSTNAME.cnf" ]]
    then
    info "Loading $HOSTNAME.cnf configuration"
    source "${SCRIPT_DIR}/$HOSTNAME.cnf"
  else
    error "The configuration file for this host ($HOSTNAME) was not found. Provide a configuration file to load."
    exit 1
  fi
else
  if [[ -e "${SCRIPT_DIR}/$1.cnf"  ]]
    then
    info "Loading $1.cnf configuration"
    source "${SCRIPT_DIR}/$1.cnf"
  else
    error "Configuration file for $1 was not found. Enter a valid configuration ($(ls ${SCRIPT_DIR}/*.cnf | sed 's/\(.*\)\.cnf/\1/' | tr '\n' ',' | sed 's/,/, /'))"
    exit 1
  fi
fi


echo
echo "Directories and files"
echo

create_dir 'Workspace & Sandbox' "$HOME/Workspace/Sandbox"
create_dir 'Local bin' "$HOME/bin"

copy_file 'Common script' "${SCRIPT_DIR}/files/common.sh" "$HOME/bin/common.sh"

echo
echo "Applications"
echo

for app in ${applications[@]}
do
  install $app
done

create_dir 'Oh-My-Zsh Custom Themes Directory' "$HOME/.oh-my-zsh/custom/themes"
copy_file 'Oh-My-Zsh Custom Theme ' "${SCRIPT_DIR}/files/af-magic-clean.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/af-magic-clean.zsh-theme"

customize_oh_my_zsh

echo
echo "Manual Installs"
echo

install_google_chrome
