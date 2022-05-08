#include <stdio.h>

#define N 10

int main()
{
    int i, n, valor, cont = 0, soma = 0;
    float media;

    for (i = 0; i < n; i++)
    {
        scanf("%d", &valor);
        soma += valor;
        cont++;
    }

    media = soma / cont;
    prinf("%d\n", media);

    return 0;
}

void escrevelinhas(int a, int m[N][N])
{
    int i, j;

    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
        {
            if (m[i][j] == a)
            {
                printf("%d", i);
                break;
            }
        }
    }
}

int tugazip(char s[])
{
    int i, j, cont = 0;

    for (i = 0; s[i] != '\0'; i++)
    {
        for (j = i + 1; s[j] != '\0'; j++)
        {
        }
    }
}