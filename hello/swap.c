#include <klee/klee.h>
void klee_make_symbolic(void *addr, size_t nbytes, const char *name) __attribute__((weak));
int main() {
	unsigned char x, y;
	klee_make_symbolic(&x, sizeof(x), "x");
	klee_make_symbolic(&y, sizeof(y), "y");
	if (x > y) {
		x = x + y;
		y = x - y;
		x = x - y;
		if (x > y) {
			return -1;
		}
	}
	return 0;
}
