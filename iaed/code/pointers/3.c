#include <stdio.h>

int main()
{
    int a[6] = {1,
                2,
                7,
                0,
                11, 6};

    int *pa = a;

    printf("%d %d %d\n", a[2], *(a + 2), *(pa + 2));

    return 0;
}