#include <stdio.h>

#include "greet.h"
#include "sum.h"

int main(void) {
  greet("World");

  int sumInt = sum_int(1, 2);
  printf("El resultado de la suma de 1 + 2 es     : %d\n\n", sumInt);

  double sumDouble = sum_double(1.0, 3.0);
  printf("El resultado de la suma de 1.0 + 3.0 es : %f\n", sumDouble);

  return 0;
}
