#include <stdio.h>
#include <stdlib.h>

typedef struct
{
    unsigned lin, col;
    double val;
} Entry;

double *getLineValues(Entry *mat, int n, int line, int nColumns)
{
    double *values;
    int i;

    values = malloc(sizeof(double) * nColumns);

    for (i = 0; i < nColumns; i++)
    {
        values[i] = 0;
    }

    for (i = 0; i < n; i++)
    {
        if (mat[i].lin == line)
        {
            values[mat[i].col] = mat[i].val;
        }
    }

    return values;
}