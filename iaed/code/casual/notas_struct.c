#include <stdio.h>

#define MAX_COD_DISC 7
#define MAX_INSCRICOES 10000

typedef struct
{
    int numero;
    int nota;
    char disciplina[MAX_COD_DISC];
} Inscricao;

int lerTodasInscricoes(Inscricao v[]);
void mostraNotasAluno(Inscricao v[], int n, int aluno);

int main()
{
    Inscricao insc[MAX_INSCRICOES];
    int numInscricoes = 0, aluno;

    numInscricoes = leTodasInscricoes(insc);
    scanf("%d", &aluno);
    while (aluno > 0)
    {
        mostraNotasAluno(insc, numInscricoes, aluno);
        scanf("%d", &aluno);
    }
    return 0;
}

int leTodasInscricoes(Inscricao v[])
{
    int n, i;
    scanf("%d", &n);
    for (i = 0; i < n; i++)
        scanf("%d%d%s", &v[i].numero, &v[i].nota, v[i].disciplina);
    return n;
}

void mostraNotasAluno(Inscricao v[], int n, int aluno)
{
    int i;
    for (i = 0; i < n; i++)
        if (aluno == v[i].numero)
            printf("%s %d\n", v[i].disciplina, v[i].nota);
}