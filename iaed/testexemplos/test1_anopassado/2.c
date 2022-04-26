#include <stdio.h>
#include <stdlib.h>

int conta_pares(int x[], int size, int n)
{
    int i, j, res = 0;

    for (i = 0; i < size; i++)
    {
        for (j = i + 1; j < size; j++)
        {
            if (x[i] + x[j] == n)
            {
                res++;
            }
        }
    }

    return res;
}