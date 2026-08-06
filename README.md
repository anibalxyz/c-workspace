# c-workspace

Entorno de desarrollo para trabajar con C/C++.

Por defecto el proyecto incluye un "Hello World".

> [!NOTE] En este punto aún no se soporta C++ directamente.

## Instalación

Instala el compilador GCC y las herramientas necesarias según la distribución Linux:

```bash
sudo ./scripts/install.sh
```

## Workflow

### Manual

Edita el código fuente `src/` y las cabeceras `include/` a tu gusto.

En esta versión manual, se compilará **todo** (sin importar si hubieron cambios) directo al binario.

Compila:

```bash
mkdir -p bin
gcc -Wall -Wextra -Iinclude $(find src -name "*.c") -o bin/main
```

Ejecuta:

```bash
./bin/main
```

### Automático

Este workflow es recomendado, más aún para proyectos grandes.

Compila:

```bash
# Compila los archivos fuente que hayan sido actualizados
# Esto llama compilación incremental
make
```

Ejecuta:

```bash
# Simplemente un alias de `./bin/main`
make run
```

Limpieza (por si se quiere compilar desde 0):

```bash
make clean
```
