#include <stdio.h>

double polyval(double pol[], int size, double x)
{
    int i1, i2;
    int soma = 0;
    int valor_ind;
    for (i1 = 0; i1 < size; i1++)
    {
        valor_ind = pol[i1];
        for (i2 = 1; i2 <= i1; i2++)
        {
            valor_ind = valor_ind * x;
        }
        soma += valor_ind;
    }

    return soma;
}

double polyvals(double pol[], int size, double x)
{
    int i, j;
    int op;
    int soma = 0;

    for (i = 1; i <= size; i++)
    {
        op = pol[i];
        for (j = 1; j <= i; j++)
        {
            op = op * x;
        }
        soma += op;
    }
    return soma;
}
