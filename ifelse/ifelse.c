#include <stdio.h>
#include <klee/klee.h>

void klee_make_symbolic(void *addr, size_t nbytes, const char *name) __attribute__((weak));

void  foo() {
//	printf("foo!\n");
}

void bar() {
//	printf("bar~~~~\n");
}

int main(int argc, char** argv)
{
	int b0; klee_make_symbolic(&b0, sizeof(b0), "b0" );if(b0) foo(); else bar();
	int b1; klee_make_symbolic(&b1, sizeof(b1), "b1" );if(b1) foo(); else bar();
	int b3; klee_make_symbolic(&b3, sizeof(b3), "b3"); if(b3) foo(); else bar();
	int b4; klee_make_symbolic(&b4, sizeof(b4), "b4"); if(b4) foo(); else bar();
	int b5; klee_make_symbolic(&b5, sizeof(b5), "b5"); if(b5) foo(); else bar();
	int b6; klee_make_symbolic(&b6, sizeof(b6), "b6"); if(b6) foo(); else bar();
	return 0;
}
