#include <stdio.h>
#include <stdlib.h>

int main()
{
    char s[1000];
    char *p;
    int i = 0;

    p = s;

    while (*p != '\0')
    {
        printf("%s", p);
        p++;
    }

    return 0;
}