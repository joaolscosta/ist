#include <stdio.h>

#define TURNOS 2
#define ALUNOS 3
#define NOTA_MINIMA 10

int main()
{
    int i, j, aprovacoes[TURNOS], alta[TURNOS], notas[TURNOS][ALUNOS];
    for (i = 0; i < TURNOS; i++)
        for (j = 0; j < ALUNOS; j++)
            scanf("%d", &notas[i][j]);
    for (i = 0; i < TURNOS; i++)
    {
        aprovacoes[i] = alta[i] = 0;
        for (j = 0; j < ALUNOS; j++)
        {
            if (notas[i][j] >= NOTA_MINIMA)
                aprovacoes[i]++;
            if (notas[i][j] > alta[i])
                alta[i] = notas[i][j];
        }
    }
    for (i = 0; i < TURNOS; i++)
        printf("Turno: %d Aprovacoes: %d, Nota mais alta: %d\n",
               i, aprovacoes[i], alta[i]);
    return 0;
}