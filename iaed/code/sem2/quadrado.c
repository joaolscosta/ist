#include <stdio.h>

/* Objetivo: Pedir ao utilizador um inteiro e devolver o seu quadrado */

int main()
{
    int n;

    printf("Introduza um valor inteiro: ");
    scanf("%d",&n);
    printf("O quadrado de %d é %d.\n\n", n, n*n);
    return 0;
}