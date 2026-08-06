#!/bin/bash

set_script_dir() {
  cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1
}

install_gcc() {
  # Arguments:
  #   $1 - target_os

  run_for_os "install_gcc" "$1"
}

install_gcc_fedora() {
  dnf install gcc -y
}

install_gcc_ubuntu() {
  apt-get update && apt-get install -y build-essential
}

install_gcc_debian() {
  apt-get update && apt-get install -y build-essential
}

main() {
  set_script_dir
  . "lib.sh"
  check_root
  detect_os

  install_gcc "$OS_TYPE"
}

main
