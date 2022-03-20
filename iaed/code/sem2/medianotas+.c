#include <stdio.h>

int main()
{
    int nota, somanotas = 0, contador = 0;
    float media;

    printf("Insira uma nota (<0 para terminar): ");
    scanf("%d", &nota);

    while (nota >= 0)
    {
        if (nota >= 10)
        {
            somanotas += nota;
            contador += 1;
        }
        scanf("%d", &nota);
    }
    media = somanotas / contador;
    
    printf("A média das notas positivas é: %.2f\n", media);
    return 0;
}