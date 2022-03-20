#include <stdio.h>

int main()
{
    int x, y, z, aux;
    int menor, maior, meio;

    printf("Insira 3 números inteiros:\n");
    scanf("%d%d%d", x, y, z);

    if (x < y) {
        aux = x;
    }
    else
    {
        aux = y;
    }
    
    if (aux < z)
    {
        menor = aux;
    }
    else
    {
        menor = z;
    }

    /* por acabar */
}