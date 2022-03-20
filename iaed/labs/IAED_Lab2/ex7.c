#include <stdio.h>

int main()
{
    int n, i, ans = 0;

    printf("Insira um inteiro: ");
    scanf("%d", &n);

    for (i = 1; i <= n; i++)
    {
        if (n % 2 == 0)
        {
            ans++;
        }
    }
    printf("primos: %d", ans);

    return 0;
}