#include <Rcpp.h>
using namespace Rcpp ;

// [[Rcpp::export]]
int sum_until_v2_cpp(int numero) { 
    int n = 0; 
    while (n < numero)
        n++;
    return n;
}
