#!/bin/bash

# Se mueve al repositorio (no debería ser necesario, pero por las dudas)
cd "$(dirname "${BASH_SOURCE[0]}")/../" || exit 1

# --- Auxiliares de Consulta ---

obtener_paginas() {
  git log --first-parent --reverse --format=%H main
}

total_paginas() {
  obtener_paginas | wc -l | tr -d ' '
}

pagina_actual() {
  local actual_hash
  actual_hash="$(git rev-parse HEAD)"
  obtener_paginas | grep -n -F "$actual_hash" | cut -d: -f1
}

# --- Auxiliares de Movimiento ---

confirmar() {
  local resp
  read -r -p "$1 [s/N]: " resp
  case "$resp" in
    s|S|y|Y|si|SI|SÍ|sí) return 0 ;;
    *) return 1 ;;
  esac
}

mover_a() {
  local destino="$1"
  local cambios
  # Ignoramos untracked (^??) y cambios en el propio script viaje.sh
  cambios="$(git status --porcelain | grep -v '^??' | grep -v 'scripts/viaje.sh')"

  if [ -n "$cambios" ]; then
    echo "¡Atención! Hay cambios sin guardar:"
    echo "$cambios" | sed 's/^/  /'
    if ! confirmar "¿Querés descartar los cambios para moverte de página?"; then
      echo "Cancelado. El proyecto no se tocó."
      exit 1
    fi
    git checkout -f -q "$destino" || exit 1
  else
    # Agregamos -f para que no trabe el checkout si el único archivo modificado es viaje.sh
    git checkout -f -q "$destino" || exit 1
  fi

  # Restaura SIEMPRE la versión más reciente de viaje.sh desde main
  git checkout main -- scripts/viaje.sh 2>/dev/null
}

# --- Comandos Principales ---

ir() {
  local num="$1"
  local total
  total="$(total_paginas)"

  if [ -z "$num" ] || ! [ "$num" -eq "$num" ] 2>/dev/null; then
    echo "Error: Indicá un número de página válido. Ej: ./scripts/viaje.sh ir 3" >&2
    exit 1
  fi

  if [ "$num" -lt 1 ] || [ "$num" -gt "$total" ]; then
    echo "Error: La página $num no existe (el libro tiene de 1 a $total páginas)." >&2
    exit 1
  fi

  local hash_destino
  hash_destino="$(obtener_paginas | sed -n "${num}p")"

  mover_a "$hash_destino"
  estado
}

inicio() {
  ir 1
}

siguiente() {
  local pag
  pag="$(pagina_actual)"

  if [ -z "$pag" ]; then
    echo "No estás en ninguna página del libro. Usá 'inicio' para entrar." >&2
    exit 1
  fi

  if [ "$pag" -ge "$(total_paginas)" ]; then
    echo "Ya estás en la última página."
    exit 0
  fi

  ir $((pag + 1))
}

anterior() {
  local pag
  pag="$(pagina_actual)"

  if [ -z "$pag" ]; then
    echo "No estás en ninguna página del libro. Usá 'inicio' para entrar." >&2
    exit 1
  fi

  if [ "$pag" -le 1 ]; then
    echo "Ya estás en la primera página."
    exit 0
  fi

  ir $((pag - 1))
}

final() {
  mover_a "main"
  echo "De vuelta en el punto actual (main):"
  estado
}

estado() {
  local pag="$(pagina_actual)"
  local total="$(total_paginas)"

  if [ -n "$pag" ]; then
    echo "Página $pag de $total: $(git log -1 --format='%s' HEAD)"
  else
    echo "Fuera del libro: $(git log -1 --format='%s' HEAD)"
  fi
}

ayuda() {
  cat >&2 <<'EOF'
Uso: ./scripts/viaje.sh <comando> [argumentos]

Lo vamos a ver como si fuera un libro.

Comandos (default: ayuda):

    ayuda       Muestra este instructivo
    inicio      Ir a la primera página
    siguiente   Avanzar una página
    anterior    Retroceder una página
    ir <num>    Ir a una página específica (ej: ir 3)
    final       Ir a la última página (punto actual del repositorio)
    estado      Muestra la página actual
EOF
}

main() {
  local cmd="${1}"

  case "$cmd" in
    inicio|siguiente|anterior|final|estado|ayuda) "$cmd" ;;
    ir) ir "$2" ;;
    *) ayuda && exit 1 ;;
  esac
}

main "$@"
