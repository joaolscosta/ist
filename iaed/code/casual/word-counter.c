#include <stdio.h>

int main()
{
    int c, palavras = 1;

    while ((c = getchar()) != EOF)
    {
        if (c == ' ' || c == '\n' || c == '\t')
        {
            palavras += 1;
        }
    }
    printf("O número de palavras é: %d\n", palavras);

    return 0;
}