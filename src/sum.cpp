/*
Siguiendo lo mencionado en sum.h:

- Se implementan las funciones sum() sobrecargadas
- Se implementan "wrappers" para C sum_int() y sum_double(), que llaman a sum().
  C ni se entera de que se usan funciones sobrecargadas (daría error) porque quien usa
  estas funciones (ej app.c) en realidad llama a las declaraciones (del .h).
  Cuando estas implementaciones se linkean, el compilador de C++ ya le hizo el Name Mangling
  a sum(), entonces internamente se están llamando funciones diferentes en cada wrapper.

Si esto no termina de quedar claro, recomiendo investigar un poco más sobre el proceso de compilación completo.
*/
#include "sum.h"
#include "logger.hpp"
int sum(int a, int b)
{
  Logger::info("Sumando dos enteros");
  return a + b;
}
double sum(double a, double b)
{
  Logger::info("Sumando dos doubles");
  return a + b;
}

// Al ser un archivo .cpp, no es necesario el condicional (como en greet.h) ya que se sabe que el compilador es C++
extern "C"
{
  int sum_int(int a, int b)
  {
    return sum(a, b);
  }
  double sum_double(double a, double b)
  {
    return sum(a, b);
  }
}
