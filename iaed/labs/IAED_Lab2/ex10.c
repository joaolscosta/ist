#include <stdio.h>

int main()
{
    int n, soma = 0, digito, contador = 0;

    printf("Insira um inteiro: ");
    scanf("%d", &n);

    while (n > 0)
    {
        contador += 1;

        digito = n % 10;
        soma += digito;
        n /= 10;
    }
    printf("Nº Dígitos: %d\tSoma Digitos: %d\n", contador, soma);

    return 0;
}