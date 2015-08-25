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

  [[ ! -e "${dest}" || -n $(diff "${file}" "${dest}") ]] && cp "${file}" "${dest}"
  [[   -e "${dest}" ]] && echo -e "${name}\t\t[OK]" || echo -e "${name}\t\t[ERROR]"
}

install_sublime_text_3() {
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


