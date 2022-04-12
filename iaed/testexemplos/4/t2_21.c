#include <stdio.h>
#include <stdlib.h>

char *trocaLetras(char *str)
{
    char *new_str;
    int str_size, i;

    str_size = strlen(str);

    new_str = malloc(sizeof(char) * str_size + 1);

    i = 0;
    while (str[i] != '\0')
    {
        if (str[i] >= 'A' && str[i] <= 'Z')
        {
            new_str[i] = str[i] - 'A' + 'a';
        }
        else if (str[i] >= 'a' && str[i] <= 'z')
        {
            new_str[i] = str[i] - 'a' + 'A';
        }
        else
        {
            new_str[i] = str[i];
        }
        i++;
    }

    return new_str;
}