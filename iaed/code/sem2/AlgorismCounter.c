#include <stdio.h>

int main()
{
    int c, contador = 0;

    while ((c = getchar()) != EOF)
    {
        if (c >= '0' && c <= '9')
        {
            contador++;
        }
    }
    printf("%d", contador);

    return 0;
}