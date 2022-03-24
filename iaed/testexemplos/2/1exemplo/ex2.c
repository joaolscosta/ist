#include <stdio.h>

#define MAX 30

int moda()
{
    int vetor[MAX];
    int valor, i = 1;

    scanf("%d", valor);
    vetor[0] = valor;

    while (valor >= 0)
    {
        scanf("%d", &valor);
        vetor[i] = valor;
        i++;
    }
}