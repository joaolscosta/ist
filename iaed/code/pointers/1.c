#include <stdio.h>

int main()
{
    int y, x = 1;
    int *px;

    px = &x;
    y = *px;
    *px = 0;

    printf("%d %d\n", x, y);

    return 0;
}