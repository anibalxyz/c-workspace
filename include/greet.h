#pragma once

// Una solución más limpia de usar extern "C" que la versión anterior.
#ifdef __cplusplus
#define EXTERN_C extern "C"
#else
#define EXTERN_C
#endif

EXTERN_C void greet(const char* name);
