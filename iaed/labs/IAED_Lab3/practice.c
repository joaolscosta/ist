#include <stdio.h>

int main()
{
    int N;
    int linha, caracter;

    printf("Insira um inteiro: ");
    scanf("%d", &N);

    for (linha = 0; linha < N; linha++)
    {
        for (caracter = 0; caracter < N; caracter++)
        {
            if (caracter == linha || caracter == N - linha - 1)
            {
                printf("*");
            }
            else
            {
                printf("-");
            }
            printf(" ");
        }
        printf("\n");
    }
    return 0;
}