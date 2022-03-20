#include <stdio.h>

int main()
{
    int contador = 0, c;

    while ((c = getchar()) != EOF)
    {
        if (c == "\n")
        {
            contador++;
        }
    }
    printf("%d", contador);

    return 0;
}