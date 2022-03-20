#include <stdio.h>

#define VECMAX 100

int main()
{
    int vetor[VECMAX];
    int n, i, max = 0;

    printf("Insira as colunas: ");
    scanf("%d", &n);

    for (i = 0; i < n; i++)
    {
        printf("número: ");
        scanf("%d", &vetor[i]);
    }

    for (i = 0; i < VECMAX; i++)
    {
        if (vetor[i] > max)
        {
            max = vetor[i];
        }
    }

    for (i = 0; i < n; i++)
    {
        if (vetor[i] > 0)
        {
            printf("*");
            vetor[i]--;
        }
        printf("\n");
    }

    return 0;
}

/* Por acabar isto não funciona */
