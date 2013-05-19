#include <stdio.h>
#include <klee/klee.h>

void klee_make_symbolic(void *addr, size_t nbytes, const char *name) __attribute__((weak));

void  foo() {
//      printf("foo!\n");
}

void bar() {
//      printf("bar~~~~\n");
}

int main(int argc, char** argv)
{
        int b0; klee_make_symbolic(&b0, sizeof(b0), "b0" );
        for(int i = 0; i < b0 + 2; i++)
        {
                b0 = b0 + 1;
                int n1 = b0;
                n1 *= b0;
                if(n1) foo(); else bar();
        }
        int b1; klee_make_symbolic(&b1, sizeof(b1), "b1" );if(b1) foo(); else bar();
        int b2; klee_make_symbolic(&b2, sizeof(b2), "b2"); if(b2) foo(); else bar();
        int b3; klee_make_symbolic(&b3, sizeof(b3), "b3"); if(b3) foo(); else bar();
        return 0;
}

