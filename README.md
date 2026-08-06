# c-workspace

Entorno de desarrollo para trabajar con C/C++.

> [!NOTE] En este punto aún no se soporta C++ directamente.

## Instalación

Instala el compilador GCC y las herramientas necesarias según la distribución Linux:

```bash
sudo ./scripts/install.sh
```

## Workflow

### Manual

Edita el archivo `src/main.c`. Por defecto incluye el típico "Hello World".

También se incluye una versión comentada `src/main_comentado.c` para los que aún no conozcan C (como yo).

Compila el archivo:

```bash
# gcc        -> compilador de C
# -Wall      -> (W = Warnings, all) activa las advertencias principales (variables no usadas, etc.)
# -Wextra    -> activa advertencias adicionales y más estrictas (comparación signed/unsigned, etc.)
# src/main.c -> archivo fuente
# -o         -> (o = output = salida) especifica el archivo ejecutable/binario
gcc -Wall -Wextra src/main.c -o bin/main
```

Ejecuta el binario:

```bash
./bin/main
```
