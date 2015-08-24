#=======================================================================================================
# Author: Johandry Amador <johandry@gmail.com>
# Title:  Variables and functions used by all the scripts
#
# Usage: source /path/to/common.sh
#
# Options:
#     -h, --help		Display this help message. bash {script_name} -h
#
# Description: This script is to be imported from other script, not to be executed from command line. It have functions and variables usefull for any shell script.
#
# Report Issues or create Pull Requests in http://github.com/johandry/vaio_ubuntu_setup/
#=======================================================================================================

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
SCRIPT_NAME="$( basename "$0" )"
LOG_FILE=/tmp/${SCRIPT_NAME%.*}.log

log () {
  msg="\e[${3};1m[${1}]\e[0m\t${2}\n"
  log="$(date +'%x - %X')\t[${1}]\t${2}\n"
  if [[ "${3}" == "ERROR" || "${3}" == "WARN" || "${3}" == "DBUG" ]]
    then
    echo -ne $msg >&2
  else # OK || INFO
    echo -ne $msg
  fi
  echo -ne $log >> "${LOG_FILE}"
}

error () {
  # Red [ERROR]
  log "ERROR" "${1}" 91
}

ok () {
  # Green [ OK ]
  log " OK " "${1}" 92  
}

warn () {
  # Yellow [WARN]
  log "WARN" "${1}" 93
}

info () {
  # Blue [INFO]
  log "INFO" "${1}" 94
}

debug () {
  # Purple [DBUG]
  log "DBUG" "${1}" 92
}

usage () {
  sed  -ne '/^# Usage/,/^# Report/p' "${0}" |
  sed   -e 's/^#\(.*\)/\1/' |
  sed   -e 's/^ \(.*\)/\1/' |
  sed   -e "s/{script_name}/${SCRIPT_NAME}/g" 
  echo

  exit 0
}

[[ "${1}" == "-h" || "${1}" == "--help" ]] && usage

