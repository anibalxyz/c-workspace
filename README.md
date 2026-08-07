# c-workspace

Entorno de desarrollo para trabajar con C/C++.

Por defecto el proyecto incluye un "Hello World" y diferentes archivos que combinan C y C++ para tener de ejemplo
un poco de todo. Se pueden borrar tranquilamente, lo importante es la estructura de carpetas y, obvio, el archivo principal.

## Instalación

Instala todas las herramientas necesarias según la distribución Linux:

```bash
sudo ./scripts/install.sh
```

## Workflow

### Manual

Edita el código fuente `src/` y las cabeceras `include/` a tu gusto.

En esta versión manual, se compilará **todo** (sin importar si hubieron cambios o no) directo al binario.

Compila:

```bash
g++ -Wall -Wextra -Iinclude $(find src -type f \( -name "*.c" -o -name "*.cpp" \)) -o bin/app
```

Ejecuta:

```bash
./bin/app
```

> [!NOTE] si cambias el nombre del archivo principal, cambialo también en estos comandos.
> bin/app -> bin/<archivo_principal>

### Automático

Este workflow es recomendado, más aún para proyectos grandes.

Compila:

```bash
# Compila los archivos fuente que hayan sido actualizados. Esto llama compilación incremental
# Opcional: MAIN=<archivo_principal> por si cambias el nombre del punto de entrada actual
make
```

Ejecuta:

```bash
# Simplemente un alias de `./bin/app`
# Opcional: MAIN=<archivo_principal>. Si en `make` pasaste un nombre distinto, usalo acá también
make run
```

Para no repetir `MAIN=<archivo_principal>` a cada rato, podés modificarlo en el archivo Makefile directamente.

Limpieza (por si se quiere compilar desde 0):

```bash
# Borra los directorios build/ y bin/
make clean
```
