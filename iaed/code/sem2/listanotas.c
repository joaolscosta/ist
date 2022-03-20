#include <stdio.h>

#define NOTA_MIN 10
#define DIM 21

int main()
{
    int total = 0, aprovacoes = 0, histograma[DIM], i, nota;

    for (i = 0; i < DIM; i++)
    {
        histograma[i] = 0;
    }
    scanf("%d", &nota);
    while (nota >= 0)
    {
        total++;
        histograma[nota]++;
        if (nota >= NOTA_MIN)
        {
            aprovacoes++;
        }
        scanf("%d", &nota);

    }
    
    return 0;
}






/*
int main()
{
    int v, cont = 0, aprovacoes = 0;

    printf("Insira uma lista de notas:\n");
    scanf("%d", &v);

    while (v >= 0)
    {
        cont++;
        if (v >= 10)
        {
            aprovacoes++;
        }
        scanf("%d", &v);
    }
    printf("%d\t%d\t%d\n", cont, aprovacoes, cont - aprovacoes);

    return 0;
}
*/