#define SYMBOLIC
//#define POSIX

#define SIZE (7)

#ifdef SYMBOLIC
#include "klee/klee.h"
#endif

#ifdef POSIX
#include <stdio.h>
#endif

#ifdef SYMBOLIC
void klee_make_symbolic(void *addr, size_t nbytes, const char *name) __attribute__((weak));
#endif

void bubble_sort(int *array, unsigned nelem) {
  for (;;) {
    int done = 1;
    unsigned i;

    for (i = 0; i + 1 < nelem; ++i) {
      if (array[i+1] < array[i]) {
        int t = array[i + 1];
        array[i + 1] = array[i];
        array[i] = t;
        done = 0;
      }
    }

    if(done)
    	break;
  }
}


int main() {
  const int N = SIZE;
  int input[N];
  int i;
  for(i = 0; i < N; i++)
	input[i] = N - i;

#ifdef SYMBOLIC
  klee_make_symbolic(&input, sizeof(input), "input");
#endif

  bubble_sort(input, N); 

#ifdef POSIX
  printf("sorted:[%d", input[0]);
  for(i = 1; i < N; i++)
	printf(", %d", input[i]);
  printf("]\n");
#endif

  return 0;
}
