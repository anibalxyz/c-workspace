#include "sum.h"

#include "logger.hpp"

int sum(int a, int b) {
  Logger::info("Sumando dos enteros");
  return a + b;
}
double sum(double a, double b) {
  Logger::info("Sumando dos doubles");
  return a + b;
}

extern "C" {
int sum_int(int a, int b) { return sum(a, b); }
double sum_double(double a, double b) { return sum(a, b); }
}
