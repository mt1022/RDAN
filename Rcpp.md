#### examples
A cpp implementation of `combn` by enumeration (only works for character vectors now):
```cpp
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
List combnCpp(CharacterVector x) {
    const int n = x.size();
    x.sort();
    CharacterVector combn1 = CharacterVector(n*(n-1)/2);
    CharacterVector combn2 = CharacterVector(n*(n-1)/2);
    int idx = 0;
    for(int i = 0; i < n - 1; i++) {
        for(int j = i + 1; j < n; j++){
            combn1[idx] = x[i];
            combn2[idx] = x[j];
            idx++;
        }
    }
    return List::create(_["V1"] = combn1, _["V2"] = combn2);
}
```
