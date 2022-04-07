#include <stdio.h>

#define TURNOS 2
#define ALUNOS 4

int main()
{
    int i, j, aprovacoes[TURNOS], alta[TURNOS], notas[TURNOS][ALUNOS];

    for (i = 0; i < TURNOS; i++)
    {
        for (j = 0; j < ALUNOS; j++)
            scanf("%d", &notas[i][j]);
    }

    printf("%d", notas[i][j]);
    return 0;
}