/* lê n e k, devolve primeiros k multiplos de n */

#include <stdio.h>

int main()
{
    int n, k;
    int i;

    printf("Insira dois números inteiros: ");
    scanf("%d%d", &n, &k);

    for (i = 1; i <= k; i++)
    {
        printf("%d\t", n * i);
    }

    return 0;
}
