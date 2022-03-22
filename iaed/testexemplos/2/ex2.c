#include <stdio.h>

#define MAX 100

int moda()
{
    int vetor[100], i, v;

    scanf("%d", &v);
    vetor[0] = v;

    while (v >= 0)
    {
        scanf("%d", &v);
        for (i = 1; i < MAX; i++)
        {
            vetor[i] = v;
        }
    }

    int x, y, temp;

    for (x = 0; x < MAX - 1; x++)
    {

        for (y = 0; y < MAX - x - 1; y++)
        {

            if (vetor[y] > vetor[y + 1])
            {

                temp = vetor[y];

                vetor[y] = vetor[y + 1];

                vetor[y + 1] = temp;
            }
        }
    }
}

int main()
{
    moda();
}