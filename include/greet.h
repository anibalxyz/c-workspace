/*
ifndef -> "If Not Defined"
GREET_H  -> Nombre del archivo en MAYÚSCULAS con guion bajo (convención de macros/constantes).

Revisa en toda la cadena de inclusión del proyecto si GREET_H ya fue procesado:
- Si NO fue procesado: lee el contenido.
- Si YA fue procesado (por cualquier otro archivo): salta hasta #endif.

Evita que haya errores por redefinición de tipos y declaraciones al incluir el mismo archivo varias veces.
Esto se llama "Include Guard".
*/
#ifndef GREET_H

// Registra la macro GREET_H en el preprocesador para marcar este archivo como procesado.
#define GREET_H

/*
Declaración / Prototipo de la función (sin implementación)

const -> garantiza que el parámetro (la cadena de caracteres) no pueda ser modificado dentro de la función.
         La variable local (el puntero) sí se puede modificar, pero no el valor original:
         - `name = "Otra cadena"` funciona
         - `*name = "Otra cadena"` o `name[0] = "Otra cadena"` no funciona
*     -> el parámetro es un puntero

El puntero apunta al primer elemento de la cadena de caracteres.
*/
void greet(const char *name);

// Cierra el bloque del "#ifndef GREET_H"
#endif
