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
