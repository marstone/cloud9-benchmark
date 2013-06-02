#include <klee/klee.h>
#include <stdio.h>

void klee_make_symbolic(void *addr, size_t nbytes, const char *name) __attribute__((weak));
void klee_assume(uintptr_t condition) __attribute__((weak));

int main()
{

	int x = 0;
	
	const int N = 4;
	int b[N];
	char name[N][4];

	for(int i = 0; i < N; i++) {
		sprintf(name[i], "b%d", i); 
//		printf("\n%s\n", name[i]);
		klee_make_symbolic(&(b[i]), sizeof(b[i]), name[i]);
	}

	if(b[0]) x++; else x--;
	if(b[1]) x++; else x--;
	if(b[2]) x++; else x--;
	if(b[3]) x++; else x--;

	return x; 
}
