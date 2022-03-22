#include <stdio.h>

double potencia(double base, double expoente)
{
    int i;
    double aux = 1.0;

    for (i = 1; i <= expoente; i++)
    {
        aux = base * aux;
    }

    return aux;
}

double polyval(double pol[], int size, double x)
{
    int i;
    double soma = 0.0;

    for (i = 0; i < size; i++)
    {
        scanf("%lf", &pol[i]);
    }

    for (i = size - 1; i >= 0; i--)
    {
        soma += (potencia(x, i) * pol[i]);
    }

    return soma;
}

int main()
{
    int size;
    double pol[size];
    double x;

    scanf("%d", &size);
    scanf("%lf", &x);
    printf("%f", polyval(pol, size, x));

    return 0;
}