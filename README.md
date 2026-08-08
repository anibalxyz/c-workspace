# c-workspace

Entorno de desarrollo para trabajar con **C** y **C++** y con integración para **VS Code**.

Por defecto se incluye un "Hello World" y algunos archivos que combinan **C** y **C++** para tener de ejemplo un poco de todo.
_Se pueden borrar tranquilamente._ Lo importante es la estructura de carpetas y, obvio, que esté el archivo principal.

## Introducción

Para armar este repositorio fui agregando características paso a paso.

También fui dejando comentarios en la parte de C/C++ de cosas que iba aprendiendo que me parecieron interesantes,
así como algunas cosas de sintaxis básicas que fui anotando para quienes no sepan nada o casi nada de C/C++ (como era mi caso).

Agregué un **script** para viajar entre esos cambios, para poder ver cómo se fueron agregando las distintas partes:

```bash
# Muestra el instructivo (inicio, siguiente, anterior, etc)
./scripts/viaje.sh ayuda
```

> [!NOTE] Aunque la idea principal es que se use en modo solo lectura,
> tiene protección por si hacés cambios mientras viajas (por si experimentás),
> pero podría fallar en algún caso que no haya testado.

**¿Qué incluye?:**

- **Soporte Híbrido C/C++:** Estructura preparada para compilar módulos en C puro, C++ o interoperabilidad entre ambos (`extern "C"`).
- **Sistema de compilación automatizado (Make):** Manejo de compilación incremental, banderas de optimización/warning y rastreo automático de headers.
- **Formateo automático (`clang-format`):** Estilo de código unificado basado en las guías de Google, integrado para formatear al guardar en VS Code.
- **Análisis estático / Linter (`clang-tidy`):** Detección en tiempo real de errores de memoria, variables no usadas y malas prácticas en el IDE.
- **Autocompletado e IntelliSense:** Generación de `compile_commands.json` (`bear`) para navegación precisa entre símbolos en VS Code y otros IDEs.
- **Instalador de dependencias:** Script en `scripts/install.sh` compatible con Ubuntu, Debian y Fedora.

## Instalación

Instala todas las herramientas necesarias según la distribución Linux (por ahora Debian/Ubuntu y Fedora):

```bash
sudo ./scripts/install.sh
```

**Esto va a instalar:** `git`, `gcc`, `g++`, `make`, `clang-format`, `clang-tidy`, `bear`

## Configuración para VS Code

El repositorio incluye la carpeta `.vscode/` con la configuración del proyecto.

**Configuraciones:**

- Formateo automático al guardar utilizando `.clang-format`
- Lectura de `compile_commands.json` para IntelliSense
  (ver comando `compiledb` en workflow [automático](#automático))
- Escaneo de la configuración de `clang-tidy` para linting integrado en el IDE
  (ver comando `lint` en workflow [automático](#automático))

Al abrir el directorio en VS Code, el IDE aplicará **automáticamente** las configuraciones para este proyecto.

**Extensiones:**

- [C/C++ (Microsoft)](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)

> [!TIP] En caso de no contar con alguna extensión necesaria, el propio editor _sugerirá su instalación_ al abrir el proyecto.

## Workflow

### Automático

Este workflow es recomendado, más aún para proyectos medianos/grandes.

También es al que le presto más atención, así que siempre va a estar actualizado, mientras que no aseguro lo mismo en el Manual.

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

Formateo:

```bash
# Formatea todos los archivos fuente y headers
make format
```

Para generar `compile_commands.json`:

```bash
make compiledb
```

> [!TIP] Esto es útil para que el Intellisense del IDE funcione correctamente.
>
> Si el proyecto es pequeño va a funcionar igual gracias a las configuracion por defecto del IDE,
> pero es recomendable usarlo por las dudas.
>
> Se debe ejecutar cuando se elimina, renombra o agrega un archivo (c o cpp),
> o cuando se modifican las flags de compilación.

Linting (depende de tener generado `compile_commands.json`):

```bash
make lint
```

> [!TIP] Algunas reglas pueden ser demasiado estrictas si se está experimentando o aprendiendo.
>
> Si te molestan las podés desactivar todas seteando "C_Cpp.codeAnalysis.clangTidy.enabled" en false
> en el archivo `.vscode/settings.json`.
>
> Si solo querés desactivar alguna puntual, borrala del la lista "Checks" en el archivo `.clang-tidy`.

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

Formateo:

```bash
clang-format -i $(find src include -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp")
```

Linting:

```bash
clang-tidy -p . $(find src -type f \( -name "*.c" -o -name "*.cpp" \))
```
