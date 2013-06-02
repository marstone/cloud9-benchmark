#include <klee/klee.h>

void klee_make_symbolic(void *addr, size_t nbytes, const char *name) __attribute__((weak));
void klee_assume(uintptr_t condition) __attribute__((weak));

int main()
{
	int N;
	klee_make_symbolic(&N, sizeof(N), "N");
//	klee_assume(N > 5);


	for(int i = 0; i < N; i++)
	{
		int x = i+1;
	}
	
	// klee_make_symbolic(&N, 8, "N");
	
	// printf("%d", sizeof(N));	

	// if(N > 0)
	//	return 0;
	//else
	//	return 1;
	return N; 
}
