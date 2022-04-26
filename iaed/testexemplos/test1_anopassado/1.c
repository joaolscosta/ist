#include <stdio.h>
#include <stdlib.h>

int main()
{
    int n, i, check = 0;

    scanf("%d", &n);

    for (i = 0; i < n; i++)
    {
        if (i * i == n)
        {
            check = 1;
            printf("%d\n", i);
            break;
        }
    }

    if (check == 0)
    {
        printf("Não éum quadrado perfeito.\n");
    }

    return 0;
}