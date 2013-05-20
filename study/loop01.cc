#include <klee/klee.h>

void klee_make_symbolic(void *addr, size_t nbytes, const char *name) __attribute__((weak));


int main()
{
	int N = 5;
	int i = 0;
	int x = 0, y = 0;
	klee_make_symbolic(&N, sizeof(N), "N");
	for(i = 0; i < N; i++)
	{
		x = x + i;
		y = y + x;
	}

	return x + y;
}
