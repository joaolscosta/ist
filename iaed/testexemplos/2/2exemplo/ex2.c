#include <stdio.h>

int mediana(int v[], int size)
{
    int i;
    double media = 0, soma = 0;

    for (i = 0; i < size; i++)
    {
        scanf("%d", &v[i]);
    }

    int j = 0;
    int k = 0;
    double res = 0;
    if (size % 2 != 0)
    {
        j = (size - 1) / 2;
        j += 1;
        res = v[j];
    }
    else
    {
        j = size / 2;
        k = j + 1;
        res = v[j] / v[k];
    }

    return res;
}

int main()
{
    int size, v[size];
    scanf("%d", &size);
    mediana(v, size);
    printf("%d", mediana(v, size));

    return 0;
}