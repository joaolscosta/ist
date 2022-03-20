#include <stdio.h>

int main()
{
    int i, n;

    printf("Insira um inteiro:");
    scanf("%d", &n);

    for (i = 1; i < n; i++)
    {
        printf("%d", i);
    }
}