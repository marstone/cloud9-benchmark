#include <klee/klee.h>

void klee_make_symbolic(void *addr, size_t nbytes, const char *name) __attribute__((weak));
void klee_assume(uintptr_t condition) __attribute__((weak));

int foo(int i) {
	return ++i;
}

int bar(int i) {
	return --i;
}

int main() {
	unsigned char flag;
	int x = 0;
	klee_make_symbolic(&flag, sizeof(flag), "flag");

	if(flag > 10) {
		x = foo(x);
	} else if(flag == 0) {
		x = bar(x);
	} else {
		x = 2 * x;
	}
	return x; 
}
