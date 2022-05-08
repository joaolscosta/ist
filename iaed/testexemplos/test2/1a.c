#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *concat(const char *s1, const char *s2)
{
    char *word = malloc(sizeof(char) * (strlen(s1) + strlen(s2) + 1));
    int i, size1, size2, cont = 0;

    size1 = strlen(s1);
    size2 = strlen(s1);

    for (i = 0; i < size1; i++)
    {
        word[i] = s1[i];
        cont++;
    }
    for (i = cont; i < size2; i++)
    {
        word[i] = s2[i];
        cont++;
    }
    word[cont + 1] = '\0';

    return word;
}

int main()
{
    char *s1, *s2, *s3;

    scanf("%s", s1);
    scanf("%s", s2);
    s3 = concat(s1, s2);
    printf("%s", s3);

    return 0;
}