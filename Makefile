CC     = gcc

# -Wall					: (W = Warnings) activa las advertencias principales (variables no usadas, etc.)
# -Wextra 			: Activa advertencias adicionales y más estrictas (comparación signed/unsigned, etc.)
# -Iinclude     : Agrega la carpeta include/ a la búsqueda de headers
# -MMD          : Genera archivos .d con las dependencias de los headers locales
# -MP 					: Crea una regla vacía por cada header para que 'make' no falle si un .h es borrado o renombrado.
CFLAGS = -Wall -Wextra -Iinclude -MMD -MP

# ==============================================================================
# Definición de Fuentes, Objetos y Dependencias
# ==============================================================================

# Busca todos los archivos .c en src/ de forma recursiva
SRC    = $(shell find src -name "*.c")

# Mapea la estructura src/*.c a build/*.o
OBJ    = $(patsubst src/%.c, build/%.o, $(SRC))

# Mapea la lista de .o a archivos de dependencias .d
DEP    = $(OBJ:.o=.d)

TARGET = bin/main

# ==============================================================================
# Reglas de Compilación
# ==============================================================================

all: $(TARGET)

# Enlace del binario final
$(TARGET): $(OBJ)
	@mkdir -p bin
	$(CC) $(OBJ) -o $@

# Regla de patrón para compilar cada .c a .o
build/%.o: src/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Incluye las reglas generadas en los archivos .d (si existen)
-include $(DEP)

clean:
	rm -rf build bin

run:
	./$(TARGET)

.PHONY: all clean run
