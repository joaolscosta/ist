#include <stdio.h>

#define VECMAX 100

int main()
{
    int n, N, i, j;
    int a[VECMAX];

    printf("Insira um inteiro inferior a 100: ");
    scanf("%d", &n);

    for (i = 0; i < n; i++)
    {
        printf("número: ");
        scanf("%d", &a[i]);
    }
    for (i = 0; i < n; i++)
    {
        N = a[i];
        for (j = 0; j < N; j++)
        {
            printf("*");
        }
        printf("\n");
    }
    return 0;
}