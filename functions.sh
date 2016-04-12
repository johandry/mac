check_app(){
  app=$1
  file=$2

  print_msg="ok ${app}"
  [[ "$3" == "--quiet" ]] && print_msg=""

  [[ -e ${file} ]] && ${print_msg}  && return 0
  return 1
}

install() {
  install_type="$(eval echo "\${$1[0]}")"
  app="$(eval echo "\${$1[1]}")"
  file="$(eval echo "\${$1[2]}")"
  install_arg="$(eval echo "\${$1[3]}")"
  post_action="$(eval echo "\${$1[4]}")"

  [[ ${install_type} == "app_store" ]] && install_app_store "${app}" "${file}" "${install_arg}" "${post_action}"
  [[ ${install_type} == "cmd" ]]       && install_cmd "${app}" "${file}" "${install_arg}" "${post_action}"
}

install_cmd() {
  app=$1
  file=$2
  install=$3

  check_app "${app}" "${file}" --quiet
  if [[ $? -eq 1 ]]
    then
    info "Installing ${app}"
    eval "${install}"
  fi

  check_app "${app}" "${file}"
  [[ $? -eq 1 ]] && error "${app}" && return 1
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
    info "Install ${app}"
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
  [[   -d "${dir}" ]] && ok "$name" || error "$name"
}

copy_file() {
  name=$1
  file=$2
  dest=$3

  [[ ! -e "${dest}" || -n $(diff "${file}" "${dest}") ]] && cp "${file}" "${dest}"
  if [[   -e "${dest}" ]]
    then
    ok "${name}"
    return 0
  else
    error "${name}"
    return 1
  fi
}

customize_oh_my_zsh() {
  theme='ZSH_THEME="af-magic-clean"'
  grep -q $theme $HOME/.zshrc || sed -i.bak "s/^ZSH_THEME=\".*\"$/$theme/" $HOME/.zshrc

  plugins='plugins=(git brew brew-cask colorize common-aliases docker docker-compose emoji emoji-clock vagrant)'
  grep -q "$plugins" $HOME/.zshrc || sed -i.bak "s/^plugins=(.*)$/$plugins/" $HOME/.zshrc

  rm -f $HOME/.zshrc.bak
  grep -q $theme $HOME/.zshrc && grep -q "$plugins" $HOME/.zshrc && ok "Oh-My-Zsh have been customized" && return 0
  error "Oh-My-Zsh couldn't been customized"
  return 0
}

install_google_chrome() {
  check_app 'Google Chrome' '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' --quiet
  if [[ $? -eq 1 ]]
    then
    echo "Download and install latest version of Google Chrome (http://www.google.com/chrome/)"
    echo "Cannot be installed with Brew because Chrome is always notifying to upgrade"
    open "http://www.google.com/chrome/"
    read -p "Press [Enter] key when it is ready ..."
  fi
  check_app 'Google Chrome' '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
}
