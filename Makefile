CC         = gcc
CXX        = g++

# -Wall					: (W = Warnings) activa las advertencias principales (variables no usadas, etc.)
# -Wextra 			: Activa advertencias adicionales y más estrictas (comparación signed/unsigned, etc.)
# -Iinclude     : Agrega la carpeta include/ a la búsqueda de headers
# -MMD          : Genera archivos .d con las dependencias de los headers locales
# -MP 					: Crea una regla vacía por cada header para que 'make' no falle si un .h es borrado o renombrado.
CFLAGS      = -Wall -Wextra -Iinclude -MMD -MP
CXXFLAGS    = -Wall -Wextra -Iinclude -MMD -MP

# ==============================================================================
# Definición de Fuentes, Objetos y Dependencias
# ==============================================================================

SRC_C      = $(shell find src -name "*.c")
SRC_CXX    = $(shell find src -name "*.cpp")

OBJ_C      = $(patsubst src/%.c, build/%.o, $(SRC_C))
OBJ_CXX    = $(patsubst src/%.cpp, build/%.o, $(SRC_CXX))

# Unificamos ambas listas en un solo OBJ para el linker y las dependencias
OBJ        = $(OBJ_C) $(OBJ_CXX)

# Mapea la lista de .o a archivos de dependencias .d
DEP        = $(OBJ:.o=.d)

MAIN			 = app

TARGET     = bin/$(MAIN)

# ==============================================================================
# Reglas de Compilación
# ==============================================================================

all: $(TARGET)

# Enlace del binario final
$(TARGET): $(OBJ)
	@mkdir -p bin
	$(CXX) $(OBJ) -o $@

build/%.o: src/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

build/%.o: src/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Incluye las reglas generadas en los archivos .d (si existen)
-include $(DEP)

clean:
	rm -rf build bin
	@mkdir build bin
	@touch build/.gitkeep bin/.gitkeep

format:
	@clang-format -i $(shell find src include -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp")

run:
	@./$(TARGET)

.PHONY: all clean run format
