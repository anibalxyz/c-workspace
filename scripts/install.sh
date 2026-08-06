#!/bin/bash

set_script_dir() {
  cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1
}

install_deps() {
  # Arguments:
  #   $1 - target_os

  run_for_os "install_deps" "$1"
}

install_deps_fedora() {
  dnf install gcc make -y
}

install_deps_ubuntu() {
  install_deps_debian
}

install_deps_debian() {
  apt-get update && apt-get install -y build-essential make
}

main() {
  set_script_dir
  . "lib.sh"
  check_root
  detect_os

  install_deps "$OS_TYPE"
}

main
