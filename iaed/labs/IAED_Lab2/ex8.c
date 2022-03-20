#include <stdio.h>
#include <float.h>

int main()
{
    float media;
    float soma = 0;
    int n, i;
    int numero;

    printf("Insira um inteiro: ");
    scanf("%d", &n);

    for (i = 1; i <= n; i++)
    {
        printf("numero: ");
        scanf("%d", &numero);
        soma += numero;
    }

    printf("A média dos números inseridos é: %.2f\n", soma / n);
    return 0;
}