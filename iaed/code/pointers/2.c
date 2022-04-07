#include <stdio.h>

void incrementa(int *t)
{
    (*t)++;
}

int main()
{
    int k = 0;
    incrementa(&k);
    printf("%d\n", k);
    return 0;
}