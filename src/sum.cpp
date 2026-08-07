#include "sum.h"

#include "logger.hpp"

int sum(int val1, int val2) {
  Logger::info("Sumando dos enteros");
  return val1 + val2;
}
double sum(double val1, double val2) {
  Logger::info("Sumando dos doubles");
  return val1 + val2;
}

extern "C" {
int sum_int(int val1, int val2) { return sum(val1, val2); }
double sum_double(double val1, double val2) { return sum(val1, val2); }
}
