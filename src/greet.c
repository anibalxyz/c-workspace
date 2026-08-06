#include <stdio.h>
#include "greet.h"

void greet(const char *name)
{
  /*
  Para no sobrecargar de comentarios, recomiendo investigar sobre cómo funciona printf() internamente.

  ¿Por qué 'name' y no '*name'?
   -> Si pasamos '*name', estamos *desreferenciando* el puntero, extrayendo el valor al que apunta (primer caracter).
      El carácter apuntado está representado con su valor ASCII, o sea un número.
      printf() está esperando en esa posición (%s) un puntero (al primer caracter de una cadena),
      si le pasamos un número mata el programa con un Segmentation Fault (Core Dumped).
    -> Al pasarle 'name', le estamos pasando la dirección de memoria.
      printf() va a esa zona de memoria, interpreta (ASCII -> carácter) e imprime valor a valor hasta encontrar el '\0'.
  */
  printf("Hello, %s! Welcome to c-workspace.\n", name);
}
