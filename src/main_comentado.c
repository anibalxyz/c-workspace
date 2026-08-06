/*
Si estás en un IDE, podés colapsar todos los bloques (código y comentarios).
Así los abrís de a uno y no saturas la vista.
Normalmente el shortcut es `ctrl + k` + `ctrl + 0`.
*/

/*
El compilador literalmente copia y pega el contenido de stdio.h
stdio.h (stdio = standard input output)
  -> es la cabecera estándar para operaciones de entrada y salida de datos (teclado, consola, archivos, etc).

Se usa  <> para bibliotecas del sistema de quien compila,
        "" para buscar primero en la carpeta local del proyecto

La extensión .h indica que el archivo contiene solo declaraciones (firmas de funciones,
tipos de datos, constantes). No tiene la lógica interna de la función.
*/
#include <stdio.h>

/*
int  -> tipo de dato que retorna la función.
        En este caso, será el código de salida (Exit Code)
main -> nombre de la funcion.
        Este nombre específico es reservado para indicar el punto de entrada, donde inicia la ejecución
()   -> parámetros de la función
void -> (void = vacío/nada) indica explícitamente que no **acepta** parámetros. 
        `()` indica un número indeterminado de parámetros no especificados.
        En C++ esto cambió y `()` equivale a `(void)`. En el estándar reciente C23, C adopta esta misma regla.
*/
int main(void) {

  /*
  Si estás en un IDE, deja el cursor sobre la función para leer la firma y descripción exactas.
  Ahora vamos a asumir el caso de uso común.

  printf() -> imprime texto formateado en consola
  \        -> carácter de escape. Seguido de una letra o símbolo, le dice a la computadora que ejecute
              un comando de formato en lugar de imprimir el texto de forma literal.
              Ejemplos: \n salto de línea, \t tabulador, \0 carácter nulo.
                        Hay varios interesantes, investigar más.

  ¿Por qué colocamos un salto de línea?
    -> activa el vaciado automático del búfer de memoria RAM (buffer flush) hacia la pantalla,
      obligando a printf a mostrar el texto inmediatamente. Si no se coloca, el texto puede quedar retenido
      en la memoria temporal y no aparecer en la terminal hasta que el programa finalice o la memoria se llene.

      Sí... yo tampoco entendí del todo, pero no parece ser relevante aún. Por lo menos no asumimos que es "porque sí".
      
  ¿De dónde saca printf() la implementación si .h solo tiene la definición/interfaz?
    -> En la fase de **enlazado** (linking), el **enlazador** (linker) conecta la promesa de la interfaz del `.h`
      con la implementación real de `printf`, la cual ya viene precompilada en la biblioteca estándar del sistema (`libc`).
      Sin este paso, el ejecutable sabría qué parámetros recibe la función, pero no qué instrucciones ejecutar.

  ¿Qué es eso del enlazado y el enlazador?
    -> Transformar un archivo de texto `.c` en un archivo ejecutable es un proceso de 4 etapas principales:
       1. Preprocesamiento: lee las directivas con `#`, copia/pega las cabeceras `.h` y resuelve macros.
       2. Compilación: traduce ese código C resultante a código ensamblador.
       3. Ensamblado: convierte el código ensamblador en código máquina, creando un archivo objeto (`.o`, `.obj`).
       4. Enlazado: el enlazador une todo para generar el archivo ejecutable/binario.

       El enlazador es simplemente el programa que se encarga de este último paso.
       Toma los archivos objetos, busca el código real de las funciones en las bibliotecas del sistema
       (como `libc` en Linux) y las conecta/asocia para que el sistema operativo sepa exactamente qué ejecutar
       cuando llamás a una función como `printf`.

       No lo creo relevante aún, pero cualquier cosa se puede investigar con más profundidad.
       
  */
  printf("Hello World!\n");

  /*
  return -> palabra clave que indica el valor de retorno de la función. También detiene su ejecución.


  0      -> Exit Code que indica éxito.
         -> 1 indicaría un error genérico (o sea, no se sabe de qué tipo). Hay más, investigar.

  Desde el estándar C99 no es necesario declarar esto explícitamente (en main), pero se mantiene el hábito.
  Si el flujo de ejecución llega a la llave de cierre } sin encontrar un return, el compilador asume e
  inserta implícitamente un "return 0;"
  */
  return 0;
}