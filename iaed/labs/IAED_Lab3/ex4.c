#include <stdio.h>

#define FORA 0
#define DENTRO 1
#define ZERO 2

int main()
{
    char c;
    int st = FORA;

    while ((c = getchar()) != EOF)
    {
        if (st == FORA)
        {

            if (c == '0')
            {
                st = ZERO;
            }
            if (c >= '1' && c <= '9')
            {
                putchar(c);
                st = DENTRO;
            }
        }
        else if (st == DENTRO)
        {
            putchar(c);
            if (c == ' ' || c == '\n' || c == EOF)
            {
                st = FORA;
            }
        }
        else
        {
            if (c >= '1' && c <= '9')
            {
                putchar(c);
                st = DENTRO;
            }
        }
    }
    if (st == ZERO)
    {
        putchar('0');
    }
    return 0;
}