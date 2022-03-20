#include <stdio.h>

int potencia(int base, int n);

int main()
{
    int i;
    for (i = 0; i < 5; i++)
    {
        printf("%d\n", potencia(3,i));
    }
    return 0;
}

int potencia(int base, int n)
{
    int i, p = 1;
    for (i = 1; i <= n; i++)
    {
        p = p * base;
    }
    return p;
}