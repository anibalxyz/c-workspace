// Sustituye el uso verboso de ifdef/endif.
// No es del estandar oficial, pero es admitido por cualquier compilador moderno.
#pragma once

/*
#ifdef __cplusplus |
(...)              |
#endif             |-> se ejecuta si el compilador es C++

extern "C" {...}   -> se ejecuta bajo el estandar C. Hace varias cosas en las que no vale la pena
                      entrar en detalle ahora (y me da pereza seguir estudiando para explicarlo resumido y preciso)
                      Una de esas es que desactiva el Name Mangling de C++:
                      mantiene el nombre de la función intacto en el binario para que el linker de C pueda encontrarlo.

Sí, es verbosa la sintaxis, queda fea la anidación, pero ya descubrí una más sencilla.
La incluyo en el siguiente commit para que esta versión quede documentada.
*/
#ifdef __cplusplus
extern "C"
{
#endif

  void greet(const char *name);

#ifdef __cplusplus
}
#endif
