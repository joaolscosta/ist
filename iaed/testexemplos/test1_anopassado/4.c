#include <stdio.h>

void comprime(char s[], int size)
{
    int i, j, cont = 0;

    for (i = 0; i < size; i++)
    {
        for (j = i + 1; j < size; j++)
        {
            if (s[i] == s[j])
                cont++;
            else
            {
                if (cont > 0)
                {
                }
            }
        }
    }
}

/* Muito bugado com este */