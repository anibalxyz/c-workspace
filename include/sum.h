#pragma once

#ifdef __cplusplus
int sum(int val1, int val2);
double sum(double val1, double val2);
#endif

#ifdef __cplusplus
extern "C" {
#endif

int sum_int(int val1, int val2);
double sum_double(double val1, double val2);

#ifdef __cplusplus
}
#endif
