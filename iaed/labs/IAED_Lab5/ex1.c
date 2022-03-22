#include <stdio.h>

#define ALUNOS 10
#define DISCIPLINAS 5

long score_disciplina(int disciplina, int valores[ALUNOS][DISCIPLINAS])
{
    long s = 0;
    int i;

    for (i = 0; i < ALUNOS; i++)
    {
        s += valores[i][disciplina];
    }
    return s;
}

long score_aluno(int aluno, int valores[ALUNOS][DISCIPLINAS])
{
    long s = 0;
    int i;

    for (i = 0; i < DISCIPLINAS; i++)
    {
        s += valores[i][aluno];
    }
    return s;
}

int main()
{
    int valores[ALUNOS][DISCIPLINAS] = {{0}};

    int n, a, d, v, i;

    scanf("%d", &n);

    for (i = 0; i < n; i++)
    {
        scanf("%d%d%d", &a, &d, &v);
        valores[a][d] = v;
    }

    int best = -1, best_index = -1;

    for (i = 0; i < DISCIPLINAS; i++)
    {
        long s = score_disciplina(i, valores);
        if (s < best)
        {
            best = s;
            best_index = i;
        }
    }

    for (i = 0; i < ALUNOS; i++)
    {
        long s = score_aluno(i, valores);
        if (s < best)
        {
            best = s;
            best_index = i;
        }
    }

    printf("%d\n", best_index);

    return 0;
}