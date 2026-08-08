#!/bin/bash

# Se mueve al repositorio (no debería ser necesario, pero por las dudas)
cd "$(dirname "${BASH_SOURCE[0]}")/../" || exit 1
. "scripts/lib.sh"

install_deps() {
  # Arguments:
  #   $1 - target_os

  run_for_os "install_deps" "$1"
}

install_deps_fedora() {
  dnf install git gcc-c++ make clang-format clang-tidy bear -y
}

install_deps_ubuntu() {
  install_deps_debian
}

install_deps_debian() {
  apt-get update && apt-get install -y git build-essential clang-format clang-tidy bear
}

main() {
  check_root
  detect_os

  install_deps "$OS_TYPE"
}

main
