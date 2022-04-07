#include <stdio.h>

int main()
{
    int nota, maiornota = 0;

    printf("Insira uma nota (<0 para terminar): ");
    scanf("%d", &nota);

    while (nota >= 0)
    {
        if (nota > maiornota)
        {
            maiornota = nota;
        }
        scanf("%d", &nota);
    }
    printf("A maior nota da lista é: %d\n", maiornota);

    return 0;
}