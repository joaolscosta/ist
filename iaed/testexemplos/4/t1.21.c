#include <stdio.h>
#include <stdlib.h>

typedef struct
{
    int numAluno;
    int nota;
} Inscricao;

int *histograma(Inscricao *insc, int n)
{
    int *notas;
    int i;

    notas = calloc(21, sizeof(int));

    for (i = 0; i < n; i++)
    {
        notas[insc[i].nota]++;
    }

    return notas;
}