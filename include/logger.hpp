/*
Este archivo es una muestra del uso de un .hpp.

Los archivos .hpp son como los .h, pero su eso es exclusivo para archivos .cpp.
Podría tener igualmente un extern "C" por ejemplo para una interfaz bajo el estandar C, pero no es algo
que interese ahora.
Si da curiosidad: por ejemplo si se llama desde Python, usando el estandar C se puede llamar a la funcion por
su nombre, en vez de adivinar cómo quedó luego del Name Mangling.

Lo voy a borrar en el siguiente commit.
*/
#pragma once

#include <iostream>
#include <string>

class Logger
{
public:
  static void info(const std::string &message)
  {
    std::cout << "[C++ Logger] " << message << "\n";
  }
};
