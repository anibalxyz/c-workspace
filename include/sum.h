/*
Ejemplo de uso de un .h con C++

Función sum() sobrecargada en C++, pero versiones con nombres distintos para C.
*/

#pragma once

#ifdef __cplusplus
int sum(int a, int b);
double sum(double a, double b);
#endif

#ifdef __cplusplus
extern "C"
{
#endif

  int sum_int(int a, int b);
  double sum_double(double a, double b);

#ifdef __cplusplus
}
#endif
