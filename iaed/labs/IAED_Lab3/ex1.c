#include <stdio.h>

void quadrado(int N);

int main()
{
    int N;
    printf("Insira um inteiro: ");
    scanf("%d", &N);
    quadrado(N);
    return 0;
}

void quadrado(int N)
{
    int i, j;

    for (i = 0; i < N; i++)
    {
        for (j = 1; j <= N; j++)
        {
            printf("%d", i + j);

            if (j == N)
            {
                printf("\n");
            }
            if (j < N)
            {
                printf("\t");
            }
        }
    }
}