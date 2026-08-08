log() {
  # Arguments:
  #   $1 - Log content
  echo "[$(date +"%Y-%m-%d %H:%M:%S")] $1"

}

check_root() {
  if [ "$EUID" -ne 0 ]; then
    echo "Error: Este script debe ejecutarse como root (usá sudo)." >&2
    exit 1
  fi
}

detect_os() {
  local os_type;

  case "$OSTYPE" in
    linux*)
      if [ -f /etc/os-release ]; then
        . /etc/os-release
        os_type="$ID"
      else
        os_type="linux"
      fi
      ;;
    darwin*)
      os_type="macos"
      ;;
    msys*|cygwin*|mingw*)
      os_type="windows"
      ;;
    *)
      os_type="unknown"
      ;;
  esac

  readonly OS_TYPE="$os_type"

  log "OS_TYPE detectado: $OS_TYPE"

  if [ "$OS_TYPE" == "windows" ] || [ "$OS_TYPE" == "macos" ] || [ "$OS_TYPE" == "unknown" ] || [ "$OS_TYPE" == "linux" ]; then
    log "OS_TYPE no soportado: $OS_TYPE"
    exit 1
  fi
}

run_for_os() {
  local action="$1"  
  local target_os="${2:-$OS_TYPE}"
  local target_func="${action}_${target_os}"

  if declare -f "$target_func" > /dev/null; then
    log "Ejecutando $action para $target_os..."
    "$target_func"
  else
    echo "Error: La acción '$action' no está soportada para '$target_os'." >&2
    return 1
  fi
}
