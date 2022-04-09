#include <stdio.h>
#include <stdlib.h>

int main()
{
    char *s[10000];
    int i;

    *s = malloc(sizeof(char) * 1000);

    for (i = 0; i < 10000; i++)
    {
        scanf("%s", s[i]);
    }
}