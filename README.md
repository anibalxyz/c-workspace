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

Compila el archivo:

```bash
# gcc        -> compilador de C
# -Wall      -> (W = Warnings, all) activa las advertencias principales (variables no usadas, etc.)
# -Wextra    -> activa advertencias adicionales y más estrictas (comparación signed/unsigned, etc.)
# -Iinclude  -> (I = Include) especifica las carpetas de inclusión, en este caso 'include'
# src/*.c    -> todos los archivos .c en la carpeta src
# -o         -> (o = output = salida) especifica el archivo ejecutable/binario
gcc -Wall -Wextra -Iinclude src/*.c -o bin/main
```

Ejecuta el binario:

```bash
./bin/main
```
