#include <klee/klee.h>
// #include <stdio.h>

void klee_make_symbolic(void *addr, size_t nbytes, const char *name) __attribute__((weak));
// void klee_assume(uintptr_t condition) __attribute__((weak));

int foo() {
	int z = 0;
	z++;
	return z;
}

int bar() {
	int z = 1;
	z--;
	return z;
}

int main()
{

	int x = 0;
	int b1, b2, b3, b4;

	klee_make_symbolic(&(b1), sizeof(b1), "b1");
	klee_make_symbolic(&(b2), sizeof(b2), "b2");
	klee_make_symbolic(&(b3), sizeof(b3), "b3");
	klee_make_symbolic(&(b4), sizeof(b4), "b4");

	if(b1) x += foo(); else x += bar();
	if(b2) x += foo(); else x += bar();
	if(b3) x += foo(); else x += bar();
	if(b4) x += foo(); else x += bar();

	return x; 
}
